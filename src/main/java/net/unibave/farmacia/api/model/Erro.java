package net.unibave.farmacia.api.model;

/**
 *
 * @author camila
 */
public class Erro {

    private String mensagem;

    public Erro(String error) {
        this.mensagem = error;
    }

    public String getMensagem() {
        return mensagem;
    }

    public void setMensagem(String mensagem) {
        this.mensagem = mensagem;
    }

}
