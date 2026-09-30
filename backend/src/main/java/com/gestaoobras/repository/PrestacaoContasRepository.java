package com.gestaoobras.repository;
import com.gestaoobras.model.entity.PrestacaoContas; import org.springframework.data.jpa.repository.JpaRepository; import org.springframework.stereotype.Repository; import java.util.UUID;
@Repository public interface PrestacaoContasRepository extends JpaRepository<PrestacaoContas, UUID> {}
