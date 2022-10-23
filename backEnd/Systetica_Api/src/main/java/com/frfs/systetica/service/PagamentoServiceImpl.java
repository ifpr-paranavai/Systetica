package com.frfs.systetica.service;

import com.frfs.systetica.dto.*;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Agendamento;
import com.frfs.systetica.entity.Pagamento;
import com.frfs.systetica.exception.BusinessException;
import com.frfs.systetica.mapper.AgendamentoMapper;
import com.frfs.systetica.mapper.PagamentoMapper;
import com.frfs.systetica.mapper.PagamentoServicoMapper;
import com.frfs.systetica.repository.AgendamentoRepository;
import com.frfs.systetica.repository.PagamentoRepository;
import com.frfs.systetica.repository.PagamentoServicoRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Optional;


@Service
@RequiredArgsConstructor
@Slf4j
public class PagamentoServiceImpl implements PagamentoService {

    private final PagamentoRepository pagamentoRepository;
    private final PagamentoServicoRepository pagamentoServicoRepository;
    private final AgendamentoRepository agendamentoRepository;

    private final PagamentoMapper pagamentoMapper;
    private final PagamentoServicoMapper pagamentoServicoMapper;
    private final AgendamentoMapper agendamentoMapper;

    private final AgendamentoService agendarServicoService;

    @Override
    public ReturnData<String> pagamentoServico(PagamentoServicoDTO pagamentoServicoDTO) {
        try {
            agendarServicoService.alterarStatusAgendamento(pagamentoServicoDTO.getAgendamento(), "FINALIZADO");

            PagamentoDTO pagamentoDTO = pagamentoServicoDTO.getPagamento();
            pagamentoDTO.setDataCadastro(new Date());

            Pagamento pagamento = pagamentoRepository.saveAndFlush(pagamentoMapper.toEntity(pagamentoDTO));

            for (ServicoDTO servicoDTO : agendamentoMapper.toDto(agendamentoRepository.findById(
                    pagamentoServicoDTO.getAgendamento().getId()).get()).getServicos()) {

                PagamentoServicoPKDTO idPagamentoServico = new PagamentoServicoPKDTO();
                idPagamentoServico.setIdPagamento(pagamentoMapper.toDto(pagamento));
                idPagamentoServico.setIdServico(servicoDTO);

                pagamentoServicoDTO.setIdPagamentoServico(idPagamentoServico);
                pagamentoServicoDTO.setValor(servicoDTO.getPreco());
                pagamentoServicoDTO.setDataCadastro(new Date());

                pagamentoServicoRepository.saveAndFlush(pagamentoServicoMapper.toEntity(pagamentoServicoDTO));
            }

            return new ReturnData<>(true, "Pagamento cadastrado com sucesso.", "");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao cadastrar pagamento", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao cadastrar pagamento",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }
}
