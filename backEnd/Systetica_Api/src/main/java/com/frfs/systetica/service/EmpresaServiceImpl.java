package com.frfs.systetica.service;

import com.frfs.systetica.dto.EmpresaDTO;
import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Empresa;
import com.frfs.systetica.exception.BusinessException;
import com.frfs.systetica.mapper.CidadeMapper;
import com.frfs.systetica.mapper.EmpresaMapper;
import com.frfs.systetica.mapper.UsuarioMapper;
import com.frfs.systetica.repository.EmpresaRepository;
import com.frfs.systetica.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class EmpresaServiceImpl implements EmpresaService {

    private final EmpresaRepository empresaRepository;
    private final EmpresaMapper empresaMapper;
    private final UsuarioRepository usuarioRepository;
    private final UsuarioMapper usuarioMapper;
    private final CidadeMapper cidadeMapper;
    private final FileBase64Service fileBase64Service;

    @Override
    public ReturnData<String> salvar(EmpresaDTO empresaDTO) {
        try {
            if (empresaRepository.findByCnpj(empresaDTO.getCnpj()).isPresent()) {
                return new ReturnData<>(false, "Cnpj já esta cadastrado no sistema.");
            }

            var returnDataConverteBase64 = fileBase64Service.converteFileBase64(empresaDTO.getLogoBase64());
            if (!returnDataConverteBase64.getSuccess()) {
                return returnDataConverteBase64;
            }

            UsuarioDTO usuarioDTO = usuarioMapper.toDto(usuarioRepository.findByEmail(
                    empresaDTO.getUsuarioAdministrador().getEmail()).get());

            empresaDTO.setLogoBase64(returnDataConverteBase64.getMessage());
            empresaDTO.setUsuarioAdministrador(usuarioDTO);
            empresaDTO.setDataCadastro(new Date());
            empresaDTO.setStatus(true);

            empresaRepository.saveAndFlush(empresaMapper.toEntity(empresaDTO));

            return new ReturnData<>(true, "Empresa salva com sucesso", "");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um empresa", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um empresa",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<String> atualizar(EmpresaDTO empresaDTO) {
        try {
            var returnDataConverteBase64 = fileBase64Service.converteFileBase64(empresaDTO.getLogoBase64());
            if (!returnDataConverteBase64.getSuccess()) {
                return returnDataConverteBase64;
            }
            Optional<Empresa> empresaBanco = empresaRepository.findById(empresaDTO.getId());

            empresaDTO.setDataCadastro(empresaBanco.get().getDataCadastro());
            empresaDTO.setCnpj(empresaBanco.get().getCnpj());
            empresaDTO.setUsuarioAdministrador(usuarioMapper.toDto(empresaBanco.get().getUsuarioAdministrador()));

            empresaRepository.saveAndFlush(empresaMapper.toEntity(empresaDTO));
            return new ReturnData<>(true, "Empresa atualizada com sucesso.");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao atualizar dados", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao atualizar dados",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<Object> buscarPorEmailAdministrador(String email) {
        Optional<Empresa> empresa = empresaRepository.findByUsuarioAdministradorEmail(email);

        if (empresa.isEmpty()) {
            return new ReturnData<>(false, "Empresa não encontrada",
                    "Não foi possível encontrar empresa pelo email " + email);
        }

        EmpresaDTO empresaDTO = empresaMapper.toDto(empresa.get());
        empresaDTO.setNomeUsuario(empresa.get().getUsuarioAdministrador().getNome().split(" ")[0]);

        return new ReturnData<>(true, "", empresaDTO);
    }
}
