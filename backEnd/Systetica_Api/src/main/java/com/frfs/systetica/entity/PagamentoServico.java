package com.frfs.systetica.entity;

import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "ass_pagamento_servico")
@EqualsAndHashCode
public class PagamentoServico implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull
    @EmbeddedId
    @Column(name = "id_pagamento_servico")
    private PagamentoServicoPK idPagamentoServico = new PagamentoServicoPK();

    @NotNull
    @Column(name = "valor")
    private Double valor;

    @NotNull
    @Column(name = "data_cadastro")
    private Date dataCadastro;

}