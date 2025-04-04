# Eager vs Lazy Loading: When to Fetch Data in JPA

## Lazy

Create a REST controller to expose the filter functionality. The controller will accept query parameters from the client.

```java
package com.example.userBorrowBook.controller;

import com.example.userBorrowBook.model.Borrow;
import com.example.userBorrowBook.repository.BorrowRepository;
import com.example.userBorrowBook.repository.BorrowSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/borrows")
public class BorrowController {

    @Autowired
    private BorrowRepository borrowRepository;

    @GetMapping
    @Transactional // Add transaction to ensure lazy-loaded entities are initialized
    public ResponseEntity<List<Borrow>> filterBorrows(
            @RequestParam(required = false) String bookTitle,
            @RequestParam(required = false) String isbn,
            @RequestParam(required = false) Boolean available,
            @RequestParam(required = false) Integer userAge,
            @RequestParam(required = false) Boolean archived,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dob,
            @RequestParam(required = false) Boolean returned
    ) {
        List<Borrow> borrows = borrowRepository.findAll(BorrowSpecification.filterByParameters(
                bookTitle, isbn, available, userAge, archived, dob, returned
        ));

        // Initialize lazy-loaded relationships to avoid serialization issues
        borrows.forEach(borrow -> {
            borrow.getBook().getTitle(); // Force initialization of book
            borrow.getUser().getUserAppName(); // Force initialization of user
        });

        return ResponseEntity.ok(borrows);
    }
}
```

The fetch operation is set to LAZY:

```java
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Borrow {

    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(name = "UUID", strategy = "org.hibernate.id.UUIDGenerator")
    private String id;

    private LocalDate borrowDate;
    private LocalDate returnDate;
    private boolean returned;
    private int points;

    // Unidirectional relationship with UserApp - LAZY loading
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private UserApp user;

    // Unidirectional relationship with Book - LAZY loading
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "book_id", nullable = false)
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Book book;
}
```

### JSON serialization

We must face a common<mark> JSON serialization problem</mark> in Spring Boot when working with <mark>Hibernate's lazy loading</mark> are caused by:

1. **Lazy Loading with Jackson Serialization**: When we try to serialize lazy-loaded entities (Book and UserApp) to JSON, Jackson tries to access proxy objects that haven't been initialized.
   
   1. **@Transactional**: we need to add `@Transactional` to ensure the transaction is still active when accessing lazy-loaded entities, and manually initialized them by accessing a property.
   
   2. **Prevent infinite recursion**: we need to add `@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})` to tell Jackson to ignore Hibernate's proxy-related fields during serialization.
   
   3. **Initialize lazy-loaded relationships**: to avoid serialization issues:
      
      ```java
               borrows.forEach(borrow -> {
                    borrow.getBook().getTitle(); // Force initialization of book
                    borrow.getUser().getUserAppName(); // Force initialization of user
                });
      ```

In this context, **initializing lazy-loaded relationships** is crucial because of how JPA (Java Persistence API) handles entity relationships. By default, JPA uses lazy loading for relationships (e.g., `Book` and `User` in the `Borrow` entity) to improve performance. This means the related entities (`Book` and `User`) are not loaded from the database until explicitly accessed.

When the `Borrow` objects are serialized into JSON (e.g., for the API response), the serialization process tries to access these lazy-loaded relationships. If they are not initialized, it results in a `LazyInitializationException` because the database session (or transaction) is already closed by the time serialization occurs.

By explicitly accessing the fields (`borrow.getBook().getTitle()` and `borrow.getUser().getUserAppName()`), the related entities are loaded into memory while the transaction is still active. This ensures the data is available during serialization, avoiding errors and ensuring the API response includes the required details. This step is **not avoidable** because the serialization process cannot handle uninitialized lazy-loaded relationships.

## Eager

To define **eager-loaded relationships**, we simply change the `fetch` attribute of the `@ManyToOne` annotation to `FetchType.EAGER`. This tells JPA to load the related entities (`Book` and `UserApp`) immediately when the `Borrow` entity is fetched, rather than lazily.

Here’s how we can modify your `Borrow` entity to use eager loading:

```java
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Borrow {

    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(name = "UUID", strategy = "org.hibernate.id.UUIDGenerator")
    private String id;

    private LocalDate borrowDate;
    private LocalDate returnDate;
    private boolean returned;
    private int points;

    // Unidirectional relationship with UserApp - Eager loading
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    //@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private UserApp user;

    // Unidirectional relationship with Book - Eager loading
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "book_id", nullable = false)
    //@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Book book;
}
```

What Happens with Eager Loading?

- When we fetch a `Borrow` entity, JPA will automatically load the associated `Book` and `UserApp` entities in the same database query (or subsequent queries, depending on the fetch strategy).
- This eliminates the need to manually initialize lazy-loaded relationships, as the data is already loaded into memory.

With eager loading we do not need to initialize Lazy-Loaded Relationships, yet the `Book` and `UserApp` entities are already loaded when the `Borrow` entity is fetched. Therefore, you can remove the following code from your controller:

```java
borrows.forEach(borrow -> {
    borrow.getBook().getTitle(); // Force initialization of book
    borrow.getUser().getUserAppName(); // Force initialization of user
});
```

### Trade-Offs of Eager Loading

While eager loading simplifies the code and avoids `LazyInitializationException`, it can lead to performance issues if:

1. **Too much data is loaded unnecessarily**: If we don’t always need the related entities, eager loading can result in fetching unnecessary data.
2. **N+1 query problem**: If the fetch strategy is not optimized, it can lead to multiple queries being executed (one for the `Borrow` and additional queries for each `Book` and `UserApp`).

#### When to Use Eager Loading?

- Use eager loading when you **always need the related entities** in your application.
- Use lazy loading when you want to **optimize performance** and only load related entities when explicitly accessed.

> In our case, if you always need the `Book` and `UserApp` details when fetching `Borrow` records, eager loading is a good choice. Otherwise, stick with lazy loading and handle initialization as you did before.
