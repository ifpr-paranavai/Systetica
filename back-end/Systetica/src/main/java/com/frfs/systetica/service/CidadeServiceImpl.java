package com.frfs.systetica.service;

import com.frfs.systetica.dto.CidadeDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.exception.BusinessException;
import com.frfs.systetica.mapper.CidadeMapper;
import com.frfs.systetica.repository.CidadeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class CidadeServiceImpl implements CidadeService {

    private final CidadeRepository cidadeRepository;

    private final CidadeMapper cidadeMapper;

    @Override
    public ReturnData<Object> salvarCidade(CidadeDTO cidadeDTO) {
        try {
            var cidade = cidadeRepository.save(cidadeMapper.toEntity(cidadeDTO));
            var cidadeSalva = cidadeMapper.toDto(cidade);
            return new ReturnData<>(true, "Cidade salva com sucesso.", cidadeSalva);
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar uma cidade.", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar uma cidade.", ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }
}
