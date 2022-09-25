package com.frfs.systetica.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;

@Component
public class InitializeData {

    @Autowired
    private DataSource dataSource;

    @EventListener(ApplicationReadyEvent.class)
    public void loadData() {
        ResourceDatabasePopulator resourceDatabasePopulatorEstado =
                new ResourceDatabasePopulator(true, false, "UTF-8",
                        new ClassPathResource("/db/insert_estados_schema.sql"));
        ResourceDatabasePopulator resourceDatabasePopulatorCidade =
                new ResourceDatabasePopulator(true, false, "UTF-8",
                        new ClassPathResource("/db/insert_cidades_schema.sql"));
        ResourceDatabasePopulator resourceDatabasePopulatorRole =
                new ResourceDatabasePopulator(true, false, "UTF-8",
                        new ClassPathResource("/db/insert_roles_schema.sql"));
        ResourceDatabasePopulator resourceDatabasePopulatorSituacao =
                new ResourceDatabasePopulator(true, false, "UTF-8",
                        new ClassPathResource("/db/insert_situacao_schema.sql"));

        resourceDatabasePopulatorEstado.execute(dataSource);
        resourceDatabasePopulatorCidade.execute(dataSource);
        resourceDatabasePopulatorRole.execute(dataSource);
        resourceDatabasePopulatorSituacao.execute(dataSource);
    }
}
