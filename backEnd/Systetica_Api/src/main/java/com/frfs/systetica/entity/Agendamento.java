package com.frfs.systetica.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "agendamento")
@EqualsAndHashCode
public class Agendamento implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nome_cliente", length = 300)
    private String nomeCliente;

    @NotNull
    @Column(name = "data_agendamento")
    private String dataAgendamento;

    @NotNull
    @Column(name = "horario_agendamento")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm")
    private LocalTime horarioAgendamento;

    @NotNull
    @Column(name = "data_cadastro")
    private Date dataCadastro;

    @NotNull
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "situacao")
    private Situacao situacao;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "cliente")
    private Usuario cliente;

    @NotNull
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "funcionario")
    private Usuario funcionario;

    @NotNull
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "empresa")
    private Empresa empresa;

    @ManyToMany()
    @JoinTable(
            name = "ass_servico_agendado",
            uniqueConstraints = @UniqueConstraint(columnNames = {"id_agendar_servico", "id_servico"}),
            joinColumns = @JoinColumn(name = "id_agendar_servico"),
            inverseJoinColumns = @JoinColumn(name = "id_servico"))
    private List<Servico> servicos = new ArrayList<>();
}