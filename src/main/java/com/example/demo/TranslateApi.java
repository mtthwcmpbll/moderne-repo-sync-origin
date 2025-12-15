package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TranslateApi {

    @Autowired
    private HelloService service;

    @GetMapping("/translate")
    public String getTranslate() {
        return service.getGreeting().toUpperCase();
    }
}
