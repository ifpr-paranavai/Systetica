package com.frfs.systetica.service;

import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.mapper.FormaPagamentoMapper;
import com.frfs.systetica.repository.FormaPagamentoRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class FormaPagamentoServiceImpl implements FormaPagamentoService {

    private final FormaPagamentoRepository formaPagamentoRepository;
    private final FormaPagamentoMapper formaPagamentoMapper;

    @Override
    public ReturnData<Object> buscarTodasFormasPagamentoPaginado(String search, Pageable page) {
        return new ReturnData<>(true, "", formaPagamentoMapper
                .toListDto(formaPagamentoRepository.findAllFields(search, page).getContent()));
    }

    @Override
    public ReturnData<Object> buscarTodasFormasPagament(Pageable page) {
        return new ReturnData<>(true, "", formaPagamentoMapper
                .toListDto(formaPagamentoRepository.findAll(page).getContent()));
    }
}
