package com.frfs.systetica.service;

import com.frfs.systetica.dto.ServicoDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Empresa;
import com.frfs.systetica.entity.Servico;
import com.frfs.systetica.exception.BusinessException;
import com.frfs.systetica.mapper.EmpresaMapper;
import com.frfs.systetica.mapper.ServicoMapper;
import com.frfs.systetica.repository.EmpresaRepository;
import com.frfs.systetica.repository.ServicoRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class ServicoServiceImpl implements ServicoService {

    private final ServicoRepository servicoRepository;
    private final ServicoMapper servicoMapper;
    private final EmpresaRepository empresaRepository;
    private final EmpresaMapper empresaMapper;

    @Override
    public ReturnData<String> salvar(ServicoDTO servicoDTO) {
        try {
            Optional<Empresa> empresa = empresaRepository.findByUsuarioAdministradorEmail(servicoDTO.getEmailAdministrativo());
            if (empresa.isEmpty()) {
                return new ReturnData<>(false, "Empresa não encontrada",
                        "Não foi possível encontrar empresa cadastrada para salvar serviço");
            }
            servicoDTO.setEmpresa(empresaMapper.toDto(empresa.get()));
            servicoDTO.setStatus(true);
            servicoDTO.setDataCadastro(new Date());

            servicoRepository.saveAndFlush(servicoMapper.toEntity(servicoDTO));
            return new ReturnData<>(true, "Servico salvo com sucesso", "");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um servico", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um servico",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<String> atualizar(ServicoDTO servicoDTO) {
        try {
            Optional<Servico> servico = servicoRepository.findById(servicoDTO.getId());

            servicoDTO.setDataCadastro(servico.get().getDataCadastro());
            servicoDTO.setEmpresa(empresaMapper.toDto(servico.get().getEmpresa()));

            servicoRepository.saveAndFlush(servicoMapper.toEntity(servicoDTO));
            return new ReturnData<>(true, "Servico atualizado com sucesso.");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao atualizar dados", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao atualizar dados",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<Object> buscarTodosPaginado(String search, Pageable page) {
        return new ReturnData<>(true, "", servicoMapper.toListDto(servicoRepository.findAllFields(search, page).getContent()));
    }

    @Override
    public ReturnData<Object> buscarTodos(Pageable page) {
        return new ReturnData<>(true, "", servicoMapper.toListDto(servicoRepository.findAll(page).getContent()));
    }
}
