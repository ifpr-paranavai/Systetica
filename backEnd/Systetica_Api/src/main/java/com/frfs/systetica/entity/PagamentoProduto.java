package com.frfs.systetica.entity;

import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "ass_pagamento_produto")
@EqualsAndHashCode
public class PagamentoProduto implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull
    @EmbeddedId
    @Column(name = "id_pagamento_produto")
    private PagamentoProdutoPK idPagamentoProduto = new PagamentoProdutoPK();

    @NotNull
    @Column(name = "quantidade")
    private Integer quantidade;

    @NotNull
    @Column(name = "valor_unitario")
    private Double valorUnitario;

    @NotNull
    @Column(name = "valor_total")
    private Double valorTotal;

    @NotNull
    @Column(name = "data_cadastro")
    private Date dataCadastro;
}