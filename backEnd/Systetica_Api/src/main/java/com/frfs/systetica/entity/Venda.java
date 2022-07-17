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
@Table(name = "venda")
@EqualsAndHashCode
public class Venda implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(name = "total")
    private Double total;

    @Column(name = "desconto")
    private Double desconto;

    @Column(name = "observacao", length = 300)
    private String observacao;

    @NotNull
    @Column(name = "data_cadastro")
    private Date dataCadastro;

    @NotNull
    @Column(name = "status", length = 1)
    private String status = String.valueOf('A');

    @NotNull
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_funcionario")
    private Funcionario idFuncionario;

    @NotNull
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_cliente")
    private Usuario idUsuario;

}