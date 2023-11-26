package net.unibave.farmacia.api.resources;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import net.unibave.farmacia.api.model.Cliente;
import net.unibave.farmacia.api.model.Erro;

/**
 *
 * @author camila
 */
@Stateless
@Path("clientes")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class ClienteResource {

    @PersistenceContext(unitName = "FarmaciaPU")
    private EntityManager entityManager;

    @GET
    public List<Cliente> findAll(@QueryParam("nome") String nome, @QueryParam("cpf") String cpf) {
        if (nome != null) {
            return entityManager
                    .createQuery("SELECT c FROM Cliente c WHERE LOWER(c.nome) LIKE LOWER(:nome)", Cliente.class)
                    .setParameter("nome", new StringBuilder("%").append(nome).append("%").toString())
                    .getResultList();
        }
        if (cpf != null) {
            return entityManager
                    .createQuery("SELECT c FROM Cliente c WHERE LOWER(c.cpf) LIKE LOWER(:cpf)", Cliente.class)
                    .setParameter("cpf", new StringBuilder("%").append(cpf).append("%").toString())
                    .getResultList();
        }

        return entityManager
                .createQuery("SELECT c FROM Cliente c", Cliente.class)
                .getResultList();
    }

    @GET
    @Path("{id}")
    public Cliente findById(@PathParam("id") Long id) {
        Cliente cliente = entityManager.find(Cliente.class, id);
        if (cliente == null) {
            String mensagem = new StringBuilder()
                    .append("Cliente ")
                    .append(String.valueOf(id))
                    .append(" não encontrado")
                    .toString();

            Response response = Response
                    .status(Response.Status.NOT_FOUND)
                    .entity(new Erro(mensagem))
                    .build();

            throw new WebApplicationException(response);
        }
        return cliente;
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Long id) {
        Cliente cliente = findById(id);
        entityManager.remove(cliente);
    }

    @POST
    public Cliente add(Cliente cliente) {
        if (cliente.getId() == 0) {
            cliente.setId(null);
        }
        entityManager.persist(cliente);
        return cliente;
    }

    @PUT
    @Path("{id}")
    public Cliente update(@PathParam("id") Long id, Cliente cliente) {
        findById(id);
        cliente.setId(id);
        return entityManager.merge(cliente);
    }

}
