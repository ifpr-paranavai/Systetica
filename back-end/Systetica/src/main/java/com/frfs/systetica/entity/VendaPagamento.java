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
@Table(name = "ass_venda_pagamento")
@EqualsAndHashCode
public class VendaPagamento implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull
    @EmbeddedId
    private VendaPagamentoPK id_venda_pagemento = new VendaPagamentoPK();

    @NotNull
    @Column(name = "tipo_pagamento", length = 50)
    private String tipoPagamento;

    @Column(name = "observacao", length = 300)
    private String observacao;

    @NotNull
    @Column(name = "data_cadastro")
    private Date dataCadastro;

}