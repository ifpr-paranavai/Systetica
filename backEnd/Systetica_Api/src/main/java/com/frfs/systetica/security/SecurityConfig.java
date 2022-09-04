package com.frfs.systetica.security;

import com.frfs.systetica.filter.CustomAuthenticationFilter;
import com.frfs.systetica.filter.CustomAuthorizationFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    private final UserDetailsService userDetailsService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(bCryptPasswordEncoder);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        CustomAuthenticationFilter customAuthenticationFilter = new CustomAuthenticationFilter(authenticationManager());
        customAuthenticationFilter.setFilterProcessesUrl("/login");
        http.csrf().disable();
        http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
        http.authorizeRequests().antMatchers(
                "/login/**",
                "/autenticacao/refresh-token/**",
                "/usuario/salvar/**",
                "/usuario/ativar/**",
                "/usuario/gerar-codigo/**",
                "/usuario/alterar-senha/**",
                "/cidade/**").permitAll();

        http.authorizeRequests().antMatchers(
                        "*",
                        "/usuario/**",
                        "/servico/buscar-todos/**",
                        "/produto/buscar-todos/**",
                        "/empresa/buscar-todos/**")
                .hasAnyAuthority("ADMINISTRADOR, FUNCIONARIO, CLIENTE");

        http.authorizeRequests().antMatchers(
                "*",
                "/empresa/**",
                "/servico/**",
                "/produto/**",
                "/buscar-funcionarios/{email}**",
                "/usuario/permissao-funcionario/**").hasAnyAuthority("ADMINISTRADOR");

        http.authorizeRequests().anyRequest().authenticated();
        http.addFilter(customAuthenticationFilter);
        http.addFilterBefore(new CustomAuthorizationFilter(), UsernamePasswordAuthenticationFilter.class);
    }

    @Bean
    @Override
    public AuthenticationManager authenticationManager() throws Exception {
        return super.authenticationManager();
    }

}
