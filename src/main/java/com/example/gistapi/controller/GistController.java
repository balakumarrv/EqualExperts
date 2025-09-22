
package com.example.gistapi.controller;

import com.example.gistapi.service.GistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class GistController {

    @Autowired
    private GistService gistService;

    @GetMapping("/{username}")
    public Map<String, Object> getGists(@PathVariable String username) {
        List<Map<String, String>> gists = gistService.fetchGists(username);
        return Map.of("user", username, "gists", gists);
    }
}
