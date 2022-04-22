//package com.frfs.systetica.config.jwt;
//
//import com.auth0.jwt.JWT;
//import com.auth0.jwt.algorithms.Algorithm;
//import com.fasterxml.jackson.databind.ObjectMapper;
//import com.frfs.systetica.entity.Cliente;
//import org.springframework.security.authentication.AuthenticationManager;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.AuthenticationException;
//import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
//
//import javax.servlet.FilterChain;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.Date;
//
//public class JWTAutenticarFilter extends UsernamePasswordAuthenticationFilter {
//
//    public static final int TOKEN_EXPIRACAO = 600_000; //10 min
//    public static final String TOKEN_SENHA = "463408a1-54c9-4307-bb1c-6cced559f5a7";
//
//    private final AuthenticationManager authenticationManager;
//
//    public JWTAutenticarFilter(AuthenticationManager authenticationManager) {
//        this.authenticationManager = authenticationManager;
//    }
//
//    @Override
//    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
//        try {
//            Cliente cliente = new ObjectMapper().readValue(request.getInputStream(), Cliente.class);
//
//            return authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
//                    cliente.getEmail(),
//                    cliente.getPassword(),
//                    new ArrayList<>()
//            ));
//        } catch (IOException e) {
//            throw new RuntimeException("Falha na autenticação do usuário ", e);
//        }
//    }
//
//    @Override
//    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authResult)
//            throws IOException {
//
//        Cliente cliente = (Cliente) authResult.getPrincipal();
//
//        String token = JWT.create().
//                withSubject(cliente.getEmail())
//                .withExpiresAt(new Date(System.currentTimeMillis() + TOKEN_EXPIRACAO))
//                .sign(Algorithm.HMAC512(TOKEN_SENHA));
//
//        response.getWriter().write(token);
//        response.getWriter().flush();
//    }
//}
