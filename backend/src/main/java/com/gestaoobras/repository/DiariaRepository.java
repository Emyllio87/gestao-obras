package com.gestaoobras.repository;

import com.gestaoobras.model.entity.Diaria;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Repository
public interface DiariaRepository extends JpaRepository<Diaria, UUID> {

    Page<Diaria> findByObraIdAndAtivoTrue(UUID obraId, Pageable pageable);

    List<Diaria> findByFuncionarioIdAndData(UUID funcionarioId, LocalDate data);

    @Query("SELECT d FROM Diaria d WHERE d.ativo = true AND d.funcionario.id = :funcionarioId AND d.data BETWEEN :inicio AND :fim")
    Page<Diaria> findByFuncionarioAndPeriod(@Param("funcionarioId") UUID funcionarioId, @Param("inicio") LocalDate inicio, @Param("fim") LocalDate fim, Pageable pageable);
}