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
@Table(name = "produto")
@EqualsAndHashCode
public class Produto implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(name = "nome", length = 100)
    private String nome;

    @NotNull
    @Column(name = "marca", length = 100)
    private String marca;

    @NotNull
    @Column(name = "preco_compra")
    private Double precoCompra;

    @NotNull
    @Column(name = "preco_venda")
    private Double precoVenda;

    @NotNull
    @Column(name = "quant_estoque")
    private Integer quantEstoque;

    @NotNull
    @Column(name = "data_cadastro")
    private Date dataCadastro;

    @NotNull
    @Column(name = "status")
    private Boolean status;

    @NotNull
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "empresa")
    private Empresa empresa;
}