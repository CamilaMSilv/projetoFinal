package net.unibave.farmacia.api.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author camila
 */
@Entity
@Table(name = "produtos")
public class Produto implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id_produtos")
    private Long id;

    @Column(name = "nomecomercpro", length = 20, nullable = false)
    private String nomeComercial;

    @Column(name = "nomequimpro", length = 100, nullable = false)
    private String nomeQuimico;

    @ManyToOne
    @JoinColumn(name = "laboratoriopro_id")
    private Laboratorio laboratorio;

    @ManyToOne
    @JoinColumn(name = "formafarmpro_id")
    private FormaFarmaceutica formaFarmaceutica;

    @ManyToOne
    @JoinColumn(name = "unidadepro_id")
    private Unidade unidade;

    @Column(name = "qtminpro")
    private Double qtMinima;

    @Column(name = "qtmaxpro")
    private Double qtMaxima;

    @Column(name = "qtestoqpro")
    private Double qtEstoque;

    @Column(name = "precocstpro")
    private Double precoCusto;

    @Column(name = "precovendapro")
    private Double precoVenda;

    @Column(name = "descpro", length = 300)
    private String descricao;

    public Produto() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNomeComercial() {
        return nomeComercial;
    }

    public void setNomeComercial(String nomeComercial) {
        this.nomeComercial = nomeComercial;
    }

    public String getNomeQuimico() {
        return nomeQuimico;
    }

    public void setNomeQuimico(String nomeQuimico) {
        this.nomeQuimico = nomeQuimico;
    }

    public Laboratorio getLaboratorio() {
        return laboratorio;
    }

    public void setLaboratorio(Laboratorio laboratorio) {
        this.laboratorio = laboratorio;
    }

    public FormaFarmaceutica getFormaFarmaceutica() {
        return formaFarmaceutica;
    }

    public void setFormaFarmaceutica(FormaFarmaceutica formaFarmaceutica) {
        this.formaFarmaceutica = formaFarmaceutica;
    }

    public Unidade getUnidade() {
        return unidade;
    }

    public void setUnidade(Unidade unidade) {
        this.unidade = unidade;
    }

    public Double getQtMinima() {
        return qtMinima;
    }

    public void setQtMinima(Double qtMinima) {
        this.qtMinima = qtMinima;
    }

    public Double getQtMaxima() {
        return qtMaxima;
    }

    public void setQtMaxima(Double qtMaxima) {
        this.qtMaxima = qtMaxima;
    }

    public Double getQtEstoque() {
        return qtEstoque;
    }

    public void setQtEstoque(Double qtEstoque) {
        this.qtEstoque = qtEstoque;
    }

    public Double getPrecoCusto() {
        return precoCusto;
    }

    public void setPrecoCusto(Double precoCusto) {
        this.precoCusto = precoCusto;
    }

    public Double getPrecoVenda() {
        return precoVenda;
    }

    public void setPrecoVenda(Double precoVenda) {
        this.precoVenda = precoVenda;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

}
