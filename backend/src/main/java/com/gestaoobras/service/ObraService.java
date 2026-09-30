package com.gestaoobras.service;
import com.gestaoobras.model.entity.Obra; import com.gestaoobras.repository.ObraRepository; import lombok.RequiredArgsConstructor; import org.springframework.data.domain.Page; import org.springframework.stereotype.Service; import java.util.UUID;
@Service @RequiredArgsConstructor public class ObraService { private final ObraRepository repo; public Page<Obra> listar(int p,int s){ return repo.findByAtivoTrue(org.springframework.data.domain.PageRequest.of(p,s)); } public Obra buscar(UUID id){ return repo.findById(id).orElse(null); } }
