package com.frfs.systetica.service;

import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.mapper.CidadeMapper;
import com.frfs.systetica.repository.CidadeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class CidadeServiceImpl implements CidadeService {

    private final CidadeRepository cidadeRepository;
    private final CidadeMapper cidadeMapper;

    @Override
    public ReturnData<Object> buscarTodasCidadesPaginado(String search, Pageable page) {
        return new ReturnData<>(true, "", cidadeMapper.toListDto(cidadeRepository.findAllFields(search, page).getContent()));
    }

    @Override
    public ReturnData<Object> buscarTodasCidades(Pageable page) {
        return new ReturnData<>(true, "", cidadeMapper.toListDto(cidadeRepository.findAll(page).getContent()));
    }
}
