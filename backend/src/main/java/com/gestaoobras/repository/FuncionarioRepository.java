package com.gestaoobras.repository;

import com.gestaoobras.model.entity.Funcionario;
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
public interface FuncionarioRepository extends JpaRepository<Funcionario, UUID> {

    Optional<Funcionario> findByCpf(String cpf);

    Page<Funcionario> findByAtivoTrue(Pageable pageable);

    Page<Funcionario> findByObraAtualIdAndAtivoTrue(UUID obraId, Pageable pageable);

    @Query("SELECT f FROM Funcionario f WHERE f.ativo = true AND (:nome IS NULL OR LOWER(f.nome) LIKE LOWER(CONCAT('%', :nome, '%'))) AND (:cpf IS NULL OR f.cpf = :cpf) AND (:funcao IS NULL OR LOWER(f.funcao) LIKE LOWER(CONCAT('%', :funcao, '%'))) AND (:obraId IS NULL OR f.obraAtual.id = :obraId)")
    Page<Funcionario> findWithFilters(@Param("nome") String nome, @Param("cpf") String cpf, @Param("funcao") String funcao, @Param("obraId") UUID obraId, Pageable pageable);

    List<Funcionario> findByObraAtualId(UUID obraId);

    boolean existsByCpf(String cpf);
}