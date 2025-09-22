
package com.example.gistapi.service;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.ResponseEntity;

import java.util.*;

@Service
public class GistService {

    public List<Map<String, String>> fetchGists(String username) {
        String url = "https://api.github.com/users/" + username + "/gists";
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<List> response = restTemplate.getForEntity(url, List.class);

        List<Map<String, Object>> rawGists = response.getBody();
        List<Map<String, String>> simplifiedGists = new ArrayList<>();

        for (Map<String, Object> gist : rawGists) {
            simplifiedGists.add(Map.of(
                "id", gist.get("id").toString(),
                "description", Objects.toString(gist.get("description"), ""),
                "url", gist.get("html_url").toString()
            ));
        }

        return simplifiedGists;
    }
}
