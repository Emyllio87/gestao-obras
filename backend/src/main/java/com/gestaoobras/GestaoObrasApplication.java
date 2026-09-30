package com.gestaoobras;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "com.gestaoobras")
public class GestaoObrasApplication {
    public static void main(String[] args) {
        SpringApplication.run(GestaoObrasApplication.class, args);
    }
}