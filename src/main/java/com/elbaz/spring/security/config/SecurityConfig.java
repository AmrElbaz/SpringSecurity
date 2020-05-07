package com.elbaz.spring.security.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    // add reference to our security datasource
    @Autowired
    DataSource securityDataSource;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        // add our users for in memory authentication
        // this method is used to configure Users (in memory, DB, LDAP, etc...)
       /* User.UserBuilder users = User.withDefaultPasswordEncoder();
        auth.inMemoryAuthentication()
                .withUser(users.username("amr").password("amr").roles("EMPLOYEE"))
                .withUser(users.username("manager").password("manager").roles("EMPLOYEE", "MANAGER"))
                .withUser(users.username("admin").password("admin").roles("EMPLOYEE", "ADMIN"));*/
       //use jdbc authentication

        auth.jdbcAuthentication().dataSource(securityDataSource)
        .usersByUsernameQuery("SELECT username, password, enabled" +
                " FROM spring_security_demo_bcrypt.users" +
                " where username = ?")
        .authoritiesByUsernameQuery("SELECT username, authority" +
                " FROM spring_security_demo_bcrypt.authorities" +
                " where username = ?");

    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        //this method is used to configure security of wev paths in application, login,logout,etc...
        http.authorizeRequests()
              //  .anyRequest().authenticated()
                .antMatchers("/").hasAnyRole("EMPLOYEE")
                .antMatchers("/managers/**").hasAnyRole("MANAGER")
                .antMatchers("/admins/**").hasAnyRole("ADMIN")
                .and()
                .formLogin()
                    .loginPage("/showMyLoginPage")
                .loginProcessingUrl("/authenticateTheUser")
                .permitAll()
                .and()
                .logout().permitAll() // adding logout support
                .and()
                .exceptionHandling()
                .accessDeniedPage("/accessDenied"); // creating custom access denied


    }
}
