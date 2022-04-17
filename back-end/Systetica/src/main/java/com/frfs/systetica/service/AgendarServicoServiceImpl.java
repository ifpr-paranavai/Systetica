package com.frfs.systetica.service;

import com.frfs.systetica.repository.AgendarServicoRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class AgendarServicoServiceImpl implements AgendarServicoService {

    @Autowired
    private AgendarServicoRepository agendarServicoRepository;
}
