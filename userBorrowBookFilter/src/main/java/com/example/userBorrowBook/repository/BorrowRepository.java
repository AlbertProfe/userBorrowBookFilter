package com.example.userBorrowBook.repository;

import com.example.userBorrowBook.model.Borrow;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
// BorrowRepository extends JpaRepository<Borrow, String>
// uses the generic type Borrow and the primary key type String
// with JpaSpecificationExecutor you can use the filterBorrows method
// with the BorrowSpecification
// JpaSpecificationExecutor is a Spring Data JPA extension that allows you to create custom query methods
// that use the Specification interface
public interface BorrowRepository extends JpaRepository<Borrow, String>, JpaSpecificationExecutor<Borrow> {
    // Custom query methods}
}