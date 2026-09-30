package com.gestaoobras.repository;

import com.gestaoobras.model.entity.Obra;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface ObraRepository extends JpaRepository<Obra, UUID> {

    Page<Obra> findByAtivoTrue(Pageable pageable);

    Page<Obra> findByStatusAndAtivoTrue(com.gestaoobras.model.enums.StatusObra status, Pageable pageable);

    @Query("SELECT o FROM Obra o WHERE o.ativo = true AND (:nome IS NULL OR LOWER(o.nome) LIKE LOWER(CONCAT('%', :nome, '%'))) AND (:status IS NULL OR o.status = :status)")
    Page<Obra> findWithFilters(@Param("nome") String nome, @Param("status") com.gestaoobras.model.enums.StatusObra status, Pageable pageable);

    List<Obra> findByResponsavelIdAndAtivoTrue(UUID responsavelId);

    boolean existsByNomeAndAtivoTrue(String nome);
}