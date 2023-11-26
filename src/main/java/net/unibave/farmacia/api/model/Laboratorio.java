package net.unibave.farmacia.api.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author camila
 */
@Entity
@Table(name = "laboratorios")
public class Laboratorio implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id_laboratorios")
    private Long id;

    @Column(name = "razsoclab", length = 200, nullable = false)
    private String razaoSocial;

    @Column(name = "nomelab", length = 200, nullable = false)
    private String nome;

    @Column(name = "areaatuaclab", length = 300)
    private String areaAtuacao;

    @Column(name = "emaillab", length = 40)
    private String email;

    @Column(name = "sitelab", length = 40)
    private String site;

    @Column(name = "fonelab", length = 16)
    private String fone;

    @Column(name = "cnpjlab", length = 18)
    private String cnpj;

    @Column(name = "enderecolab", length = 40)
    private String endereco;

    @Column(name = "numenderecolab", length = 10)
    private String numeroEndereco;

    @Column(name = "complementolab", length = 30)
    private String complemento;

    @Column(name = "bairrolab", length = 20)
    private String bairro;

    @Column(name = "cidadelab", length = 20)
    private String cidade;

    @Column(name = "ceplab", length = 10)
    private String cep;

    @Column(name = "estadolab", length = 20)
    private String estado;

    public Laboratorio() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    
    public String getRazaoSocial() {
        return razaoSocial;
    }

    public void setRazaoSocial(String razaoSocial) {
        this.razaoSocial = razaoSocial;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getAreaAtuacao() {
        return areaAtuacao;
    }

    public void setAreaAtuacao(String areaAtuacao) {
        this.areaAtuacao = areaAtuacao;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site;
    }

    public String getFone() {
        return fone;
    }

    public void setFone(String fone) {
        this.fone = fone;
    }

    public String getCnpj() {
        return cnpj;
    }

    public void setCnpj(String cnpj) {
        this.cnpj = cnpj;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public String getNumeroEndereco() {
        return numeroEndereco;
    }

    public void setNumeroEndereco(String numeroEndereco) {
        this.numeroEndereco = numeroEndereco;
    }

    public String getComplemento() {
        return complemento;
    }

    public void setComplemento(String complemento) {
        this.complemento = complemento;
    }

    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

}
