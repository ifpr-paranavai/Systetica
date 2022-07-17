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
@Table(name = "ass_venda_produto")
@EqualsAndHashCode
public class VendaProduto implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull
    @EmbeddedId
    private VendaProdutoPK id_venda_produto = new VendaProdutoPK();

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