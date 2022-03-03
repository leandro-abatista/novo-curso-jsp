package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.If;

import dao.DAOProdutoRepository;
import dao.DaoEstoqueRepository;
import model.Ajuste;
import model.Produto;

@WebServlet("/ServletEstoqueProduto")
public class ServletEstoqueProduto extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private DAOProdutoRepository produtoRepository = new DAOProdutoRepository();
	
	private DaoEstoqueRepository estoqueRepository = new DaoEstoqueRepository();

	public ServletEstoqueProduto() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

			String acao = request.getParameter("acao");

			if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listaDeProdutos")) {

				// CARREGA A LISTA DE PRODUTOS APÓS CARREGAR A PÁGINA DE PRODUTOS
				List<Produto> produtos = produtoRepository.listaDeProdutosCadastrados();
				request.setAttribute("listaDeProdutos", produtos);


			} if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listaDeProdutosAjustados")) {

				// CARREGA A LISTA DE PRODUTOS APÓS CARREGAR A PÁGINA DE PRODUTOS
				List<Ajuste> ajustes = estoqueRepository.listaDeAjustesDeProdutos();
				request.setAttribute("listaDeProdutosAjustados", ajustes);


			}  
			
			else {

				// CARREGA A LISTA DE PRODUTOS APÓS CARREGAR A PÁGINA DE PRODUTOS
				List<Produto> produtos = produtoRepository.listaDeProdutosCadastrados();
				request.setAttribute("listaDeProdutos", produtos);

			}

			request.getRequestDispatcher("principal/estoque.jsp").forward(request, response);

		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		String id = request.getParameter("id");
		String quantidade = request.getParameter("quantidade");
		String movimentacao = request.getParameter("movimentacao");
		String idProduto = request.getParameter("produto");
		
		Ajuste ajuste = new Ajuste();
		ajuste.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
		ajuste.setMovimentacao(movimentacao);
		ajuste.setQuantidade(Integer.parseInt(quantidade));
		ajuste.setIdproduto(Long.parseLong(idProduto));;
		
		try {
			
			estoqueRepository.gravarAjuste(ajuste);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("/error/erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
		}
	}

}
