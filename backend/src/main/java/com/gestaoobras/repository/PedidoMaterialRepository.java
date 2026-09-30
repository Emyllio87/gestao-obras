package com.gestaoobras.repository;
import com.gestaoobras.model.entity.PedidoMaterial; import org.springframework.data.jpa.repository.JpaRepository; import org.springframework.stereotype.Repository; import java.util.UUID;
@Repository public interface PedidoMaterialRepository extends JpaRepository<PedidoMaterial, UUID> {}
