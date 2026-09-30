package com.gestaoobras.repository;

import com.gestaoobras.model.entity.Fornecedor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface FornecedorRepository extends JpaRepository<Fornecedor, UUID> {

    Optional<Fornecedor> findByCnpj(String cnpj);

    Page<Fornecedor> findByAtivoTrue(Pageable pageable);

    @Query("SELECT f FROM Fornecedor f WHERE f.ativo = true AND (:nome IS NULL OR LOWER(f.nome) LIKE LOWER(CONCAT('%', :nome, '%'))) AND (:cnpj IS NULL OR f.cnpj = :cnpj)")
    Page<Fornecedor> findWithFilters(@Param("nome") String nome, @Param("cnpj") String cnpj, Pageable pageable);

    boolean existsByCnpj(String cnpj);
}