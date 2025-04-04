package com.example.userBorrowBook.repository;


import com.example.userBorrowBook.model.Book;
import com.example.userBorrowBook.model.Borrow;
import com.example.userBorrowBook.model.UserApp;
import jakarta.persistence.criteria.*;
import org.springframework.data.jpa.domain.Specification;
import java.time.LocalDate;

public class BorrowSpecification {
    // Custom specification for filtering borrows
    // Filter by book title, ISBN, availability, user age,
    // user archived status, user DOB, and returned status
    public static Specification<Borrow> filterByParameters(
            String bookTitle,
            String isbn,
            Boolean available,
            Integer userAge,
            Boolean archived,
            LocalDate dob,
            Boolean returned
    ) {

        // Define the criteria for filtering, os we are using JPA Criteria API
        // with lambda expression and 3 parameters: root, query, and criteriaBuilder
        // where root is the root entity,
        // query is the query object
        // (CriteriaQuery<?> where ? isº the return type dynamically set by the query),
        // and criteriaBuilder is the criteria builder
        return (Root<Borrow> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) -> {

            // Define the predicate for filtering using criteriaBuilder
            // to create a conjunction of predicates and add them to the query
            // using the 'and' (conjunction) method of the criteriaBuilder
            Predicate predicate = criteriaBuilder.conjunction();

            // Join the 'book' and 'user' entities to the 'borrow' entity
            Join<Borrow, Book> bookJoin = root.join("book", JoinType.INNER);
            // Join the 'user' entity to the 'borrow' entity
            Join<Borrow, UserApp> userJoin = root.join("user", JoinType.INNER);

            // Apply filters based on the provided parameters

            // Filter by book title creating a predicate and adding it to the query
            // using the 'and' (conjunction) method of the criteriaBuilder
            // using the 'like' (contains) method of the criteriaBuilder
            // using the "%" + bookTitle + "%" to match any part of the book title
            if (bookTitle != null && !bookTitle.isEmpty()) {
                predicate = criteriaBuilder.and(predicate, criteriaBuilder.like(bookJoin.get("title"), "%" + bookTitle + "%"));
            }

            if (isbn != null && !isbn.isEmpty()) {
                predicate = criteriaBuilder.and(predicate, criteriaBuilder.equal(bookJoin.get("isbn"), isbn));
            }

            if (available != null) {
                predicate = criteriaBuilder.and(predicate, criteriaBuilder.equal(bookJoin.get("available"), available));
            }

            if (userAge != null) {
                predicate = criteriaBuilder.and(predicate, criteriaBuilder.lessThan(userJoin.get("age"), userAge));
            }

            if (archived != null) {
                predicate = criteriaBuilder.and(predicate, criteriaBuilder.equal(userJoin.get("archived"), archived));
            }

            if (dob != null) {
                predicate = criteriaBuilder.and(predicate, criteriaBuilder.equal(userJoin.get("dob"), dob));
            }

            if (returned != null) {
                predicate = criteriaBuilder.and(predicate, criteriaBuilder.equal(root.get("returned"), returned));
            }

            return predicate;
        };
    }
}
