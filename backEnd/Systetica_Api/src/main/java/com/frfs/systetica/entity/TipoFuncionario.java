package com.frfs.systetica.entity;

import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "tipo_funcionario")
@EqualsAndHashCode
public class TipoFuncionario implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(name = "tipo", length = 100)
    private String tipo;

    @Column(name = "observacao", length = 300)
    private String observacao;

    @NotNull
    @Column(name = "data_cadastro")
    private Date dataCadastro;

    @NotNull
    @Column(name = "status", length = 1)
    private String status = String.valueOf('A');

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(
            name = "ass_tipo_do_funcionario",
            uniqueConstraints = @UniqueConstraint(columnNames = {"id_tipo_funcionario", "id_funcionario"}),
            joinColumns = @JoinColumn(name = "id_tipo_funcionario"),
            inverseJoinColumns = @JoinColumn(name = "id_funcionario"))
    private List<Funcionario> funcionarios = new ArrayList<>();
}