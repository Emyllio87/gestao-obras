package com.gestaoobras.repository;
import com.gestaoobras.model.entity.Reembolso; import org.springframework.data.jpa.repository.JpaRepository; import org.springframework.stereotype.Repository; import java.util.UUID;
@Repository public interface ReembolsoRepository extends JpaRepository<Reembolso, UUID> {}
