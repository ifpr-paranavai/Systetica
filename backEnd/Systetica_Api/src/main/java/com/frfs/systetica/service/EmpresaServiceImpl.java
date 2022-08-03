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
    private final UsuarioService usuarioService;
    private final CidadeMapper cidadeMapper;

    @Override
    public ReturnData<String> salvar(EmpresaDTO empresaDTO) {
        try {
            if (empresaRepository.findByCnpj(empresaDTO.getCnpj()).isPresent()) {
                return new ReturnData<>(false, "Cnpj já esta cadastrado no sistema.");
            }

            var returnDataConverteBase64 = usuarioService.converteFileBase64(empresaDTO.getLogoBase64());
            if (!returnDataConverteBase64.getSuccess()) {
                return returnDataConverteBase64;
            }

            UsuarioDTO usuarioDTO = usuarioMapper.toDto(usuarioRepository.findByEmail(
                    empresaDTO.getUsuarioAdministrador().getEmail()).get());

            empresaDTO.setLogoBase64(returnDataConverteBase64.getMessage());
            empresaDTO.setUsuarioAdministrador(usuarioDTO);
            empresaDTO.setDataCadastro(new Date());

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
            var returnDataConverteBase64 = usuarioService.converteFileBase64(empresaDTO.getLogoBase64());
            if (!returnDataConverteBase64.getSuccess()) {
                return returnDataConverteBase64;
            }

            Optional<Empresa> empresaBanco = empresaRepository.findById(empresaDTO.getId());

            empresaBanco.get().setNome(empresaDTO.getNome());
            empresaBanco.get().setTelefone1(empresaDTO.getTelefone1());
            empresaBanco.get().setTelefone2(empresaDTO.getTelefone2());
            empresaBanco.get().setEndereco(empresaDTO.getEndereco());
            empresaBanco.get().setNumero(empresaDTO.getNumero());
            empresaBanco.get().setCep(empresaDTO.getCep());
            empresaBanco.get().setLatitude(empresaDTO.getLatitude());
            empresaBanco.get().setLongitude(empresaDTO.getLongitude());
            empresaBanco.get().setLogoBase64(returnDataConverteBase64.getMessage());
            empresaBanco.get().setCidade(cidadeMapper.toEntity(empresaDTO.getCidade()));

            empresaRepository.saveAndFlush(empresaBanco.get());
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
            return new ReturnData<>(false, "Empresa não encontrada.",
                    "Não foi possível encontrar empresa pelo email " + email);
        }

        return new ReturnData<>(true, "", empresaMapper.toDto(empresa.get()));
    }
}
