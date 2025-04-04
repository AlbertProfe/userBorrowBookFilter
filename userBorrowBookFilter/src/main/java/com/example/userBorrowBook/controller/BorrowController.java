package com.example.userBorrowBook.controller;


import com.example.userBorrowBook.model.Borrow;
import com.example.userBorrowBook.repository.BorrowRepository;
import com.example.userBorrowBook.repository.BorrowSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/borrows")
@CrossOrigin("*")
public class BorrowController {

    @Autowired
    private BorrowRepository borrowRepository;

    @GetMapping
    //@Transactional // Add transaction to ensure lazy-loaded entities are initialized
    public ResponseEntity<List<Borrow>> filterBorrows(
            @RequestParam(required = false) String bookTitle,
            @RequestParam(required = false) String isbn,
            @RequestParam(required = false) Boolean available,
            @RequestParam(required = false) Integer userAge,
            @RequestParam(required = false) Boolean archived,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dob,
            @RequestParam(required = false) Boolean returned
    ) {
        // communicate repo with h2
        // to create dynamic queries
        // by the implementation of BorrowSpecification
        // to avoid boilerplate native sql
        List<Borrow> borrows = borrowRepository.findAll(BorrowSpecification.filterByParameters(
                bookTitle, isbn, available, userAge, archived, dob, returned
        ));

        // Initialize lazy-loaded relationships to avoid serialization issues
       /* borrows.forEach(borrow -> {
            borrow.getBook().getTitle(); // Force initialization of book
            borrow.getUser().getUserAppName(); // Force initialization of user
        });*/

        return ResponseEntity.ok(borrows);
    }
}