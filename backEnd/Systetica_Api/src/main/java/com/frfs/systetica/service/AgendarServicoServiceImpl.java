package com.frfs.systetica.service;

import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.AgendarServico;
import com.frfs.systetica.mapper.AgendarServicoMapper;
import com.frfs.systetica.repository.AgendarServicoRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class AgendarServicoServiceImpl implements AgendarServicoService {

    private final AgendarServicoRepository agendarServicoRepository;
    private final AgendarServicoMapper agendarServicoMapper;

    @Override
    public ReturnData<Object> buscarTodosPorDia(String dataAgendamento) {
        List<AgendarServico> servicosAgendados = agendarServicoRepository.findByDataAgendamento(dataAgendamento);

        if (servicosAgendados.isEmpty()) {
            return new ReturnData<>(false, "Nenhum serviço encontrada",
                    "Não foi possível encontrar nenhuma serviço pela data " + dataAgendamento);
        }
        return new ReturnData<>(true, "", agendarServicoMapper.toListDto(servicosAgendados));
    }
}
