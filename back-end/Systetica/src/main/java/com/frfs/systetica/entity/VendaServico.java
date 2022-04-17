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
@Table(name = "ass_venda_servico")
@EqualsAndHashCode
public class VendaServico implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull
    @EmbeddedId
    private VendaServicoPK id_venda_servico = new VendaServicoPK();

    @NotNull
    @Column(name = "quantidade")
    private Integer quantidade;

    @NotNull
    @Column(name = "valor_unitario")
    private Double valorUnitario;

    @NotNull
    @Column(name = "valor_total")
    private Double valorTotal;

    @Column(name = "observacao", length = 300)
    private String observacao;

    @NotNull
    @Column(name = "data_cadastro")
    private Date dataCadastro;

}