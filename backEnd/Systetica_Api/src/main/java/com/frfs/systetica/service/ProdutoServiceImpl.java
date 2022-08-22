package com.frfs.systetica.service;

import com.frfs.systetica.dto.ProdutoDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Empresa;
import com.frfs.systetica.entity.Produto;
import com.frfs.systetica.exception.BusinessException;
import com.frfs.systetica.mapper.EmpresaMapper;
import com.frfs.systetica.mapper.ProdutoMapper;
import com.frfs.systetica.repository.EmpresaRepository;
import com.frfs.systetica.repository.ProdutoRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProdutoServiceImpl implements ProdutoService {

    private final ProdutoRepository produtoRepository;
    private final ProdutoMapper produtoMapper;
    private final EmpresaRepository empresaRepository;
    private final EmpresaMapper empresaMapper;

    @Override
    public ReturnData<String> salvar(ProdutoDTO produtoDTO) {
        try {
            Optional<Empresa> empresa = empresaRepository.findByUsuarioAdministradorEmail(produtoDTO.getEmailAdministrativo());
            if (empresa.isEmpty()) {
                return new ReturnData<>(false, "Empresa não encontrada",
                        "Não foi possível encontrar empresa cadastrada para salvar produto");
            }
            produtoDTO.setEmpresa(empresaMapper.toDto(empresa.get()));
            produtoDTO.setStatus(true);
            produtoDTO.setDataCadastro(new Date());

            produtoRepository.saveAndFlush(produtoMapper.toEntity(produtoDTO));
            return new ReturnData<>(true, "Produto salvo com sucesso", "");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um produto", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um produto",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<String> atualizar(ProdutoDTO produtoDTO) {
        try {
            Optional<Produto> produto = produtoRepository.findById(produtoDTO.getId());

            produtoDTO.setDataCadastro(produto.get().getDataCadastro());
            produtoDTO.setEmpresa(empresaMapper.toDto(produto.get().getEmpresa()));


            produtoRepository.saveAndFlush(produtoMapper.toEntity(produtoDTO));
            return new ReturnData<>(true, "Produto atualizado com sucesso.");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao atualizar dados", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao atualizar dados",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<Object> buscarTodosPaginado(String search, Pageable page, String emailAdministrativo) {
        return new ReturnData<>(true, "", produtoMapper.toListDto(produtoRepository
                .findAllFields(search, page, emailAdministrativo).getContent()));
    }

    @Override
    public ReturnData<Object> buscarTodos(Pageable page, String emailAdministrativo) {
        return new ReturnData<>(true, "", produtoMapper.toListDto(produtoRepository
                .findAll(page, emailAdministrativo).getContent()));
    }
}
