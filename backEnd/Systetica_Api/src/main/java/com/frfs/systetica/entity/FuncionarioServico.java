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
@Table(name = "ass_funcionario_servico")
@EqualsAndHashCode
public class FuncionarioServico implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull
    @EmbeddedId
    private FuncionarioServicoPK id_funcionario_servico = new FuncionarioServicoPK();

    @Column(name = "desconto")
    private Double valorUnitario;

    @Column(name = "total")
    private Double total;

    @Column(name = "realiza_todos_servicos")
    private Boolean realizaTodosServicos;

    @Column(name = "observacao", length = 300)
    private String observacao;

    @NotNull
    @Column(name = "data_cadastro")
    private Date dataCadastro;

}