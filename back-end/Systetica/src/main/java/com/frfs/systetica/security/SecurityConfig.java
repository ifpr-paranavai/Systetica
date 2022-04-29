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

import static org.springframework.http.HttpMethod.*;

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
        customAuthenticationFilter.setFilterProcessesUrl("/api/login");//isso meio que sobrescreve o /login padrão do spring
        http.csrf().disable();
        http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
        //TODO - todas as URLs que podem ser acessadas sem esta autenticado
        http.authorizeRequests().antMatchers("/api/login/**", "/autenticacao/refresh-token/**", "/cliente/salvar/**").permitAll(); //isso meio que sobrescreve o /login padrão do spring
        http.authorizeRequests().antMatchers(GET, "/cliente/**").hasAnyAuthority("ADMINISTRADOR");
        http.authorizeRequests().antMatchers(PUT, "/cliente/**").hasAnyAuthority("ADMINISTRADOR");
        http.authorizeRequests().antMatchers(POST, "/cliente/**").hasAnyAuthority("ADMINISTRADOR");
        http.authorizeRequests().antMatchers(DELETE, "/cliente/**").hasAnyAuthority("ADMINISTRADOR");
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
