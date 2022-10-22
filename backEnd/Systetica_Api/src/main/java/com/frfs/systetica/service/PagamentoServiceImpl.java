package com.frfs.systetica.service;

import com.frfs.systetica.dto.PagamentoServicoDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.repository.PagamentoRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class PagamentoServiceImpl implements PagamentoService {

    private final PagamentoRepository pagamentoRepository;

    @Override
    public ReturnData<String> pagamentoServico(PagamentoServicoDTO pagamentoServicoDTO) {
        return null;
    }
}
