package com.frfs.systetica;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@Slf4j
@RequiredArgsConstructor
@EnableScheduling
public class SysteticaApplication {

    public static void main(String[] args) {
        SpringApplication.run(SysteticaApplication.class, args);
    }

}
