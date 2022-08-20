package com.frfs.systetica.service;

import com.frfs.systetica.dto.EmpresaDTO;
import com.frfs.systetica.dto.ProdutoDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Empresa;
import com.frfs.systetica.entity.Produto;
import com.frfs.systetica.mapper.EmpresaMapper;
import com.frfs.systetica.mapper.ProdutoMapper;
import com.frfs.systetica.repository.EmpresaRepository;
import com.frfs.systetica.repository.ProdutoRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentMatchers;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.ActiveProfiles;

import java.util.Date;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@ActiveProfiles(profiles = "local")
@AutoConfigureMockMvc
@DisplayName("ServicoServiceTest")
public class ProdutoServiceTest {

    @MockBean
    private ProdutoRepository produtoRepository;

    @MockBean
    private ProdutoMapper produtoMapper;

    @MockBean
    private EmpresaRepository empresaRepository;

    @MockBean
    private EmpresaMapper empresaMapper;

    @Autowired
    private ProdutoServiceImpl produtoService;

    public ProdutoServiceTest() {
    }

    @Test
    @DisplayName("Deve salvar um produto")
    public void deveSalvarProduto() {
        String emailAdministrativo = "systetica@gmail.com.br";

        Produto produto = Mockito.mock(Produto.class);
        ProdutoDTO produtoDTO = Mockito.mock(ProdutoDTO.class);

        Empresa empresa = Mockito.mock(Empresa.class);
        EmpresaDTO empresaDTO = Mockito.mock(EmpresaDTO.class);
        Optional<Empresa> empresaOptional = Optional.of(empresa);

        Mockito.when(empresaOptional.get().getId()).thenReturn(1L);

        Mockito.when(produtoDTO.getNome()).thenReturn("Systetica");
        Mockito.when(produtoDTO.getEmailAdministrativo()).thenReturn(emailAdministrativo);
        Mockito.when(produtoDTO.getEmpresa()).thenReturn(empresaDTO);

        Mockito.when(empresaRepository.findByUsuarioAdministradorEmail(ArgumentMatchers.eq(emailAdministrativo)))
                .thenReturn(empresaOptional);
        Mockito.when(empresaMapper.toDto(empresaOptional.get())).thenReturn(empresaDTO);
        Mockito.when(produtoMapper.toEntity(produtoDTO)).thenReturn(produto);

        ReturnData<String> returnData = new ReturnData<>(true, "Produto salvo com sucesso", "");
        assertEquals(produtoService.salvar(produtoDTO), returnData);
    }

    @Test
    @DisplayName("Deve atualizar um produto")
    public void deveAtualizarProduto() {
        Produto produto = Mockito.mock(Produto.class);
        ProdutoDTO produtoDTO = Mockito.mock(ProdutoDTO.class);
        Optional<Produto> produtoOptional = Optional.of(produto);

        Mockito.when(produtoDTO.getId()).thenReturn(1L);
        Mockito.when(produto.getDataCadastro()).thenReturn(new Date());

        Mockito.when(produtoRepository.findById(produtoDTO.getId())).thenReturn(produtoOptional);
        Mockito.when(produtoMapper.toEntity(produtoDTO)).thenReturn(produto);

        ReturnData<String> returnData = new ReturnData<>(true, "Produto atualizado com sucesso.");
        assertEquals(produtoService.atualizar(produtoDTO), returnData);
    }

    // Testes para ReturnData false
    @Test
    @DisplayName("Deve informa que empresa não foi encontrada")
    public void deveInformaEmpresaNaoEncontrada() {
        ProdutoDTO produtoDTO = Mockito.mock(ProdutoDTO.class);

        Optional<Empresa> empresaOptional = Optional.empty();

        Mockito.when(empresaRepository.findByUsuarioAdministradorEmail(
                ArgumentMatchers.eq("systetica@gmail.com.br"))).thenReturn(empresaOptional);

        ReturnData<String> returnData = new ReturnData<>(false, "Empresa não encontrada",
                "Não foi possível encontrar empresa cadastrada para salvar produto");
        assertEquals(produtoService.salvar(produtoDTO), returnData);
    }
}
