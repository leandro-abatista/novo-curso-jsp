package servlets;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAOProdutoRepository;
import model.Produto;

@WebServlet("/ServletProdutoController")
public class ServletProduto extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private DAOProdutoRepository produtoRepository = new DAOProdutoRepository();

	public ServletProduto() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			
			String acao = request.getParameter("acao");
			
			if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listProduct")) {
				List<Produto> produtos;
				
					produtos = produtoRepository.listaDeProdutosCadastrados();
				
				request.setAttribute("listaDeProdutos", produtos);
			}
			
			request.getRequestDispatcher("principal/cad_produto.jsp").forward(request, response);
			
			} catch (Exception e) {
				e.printStackTrace();
				RequestDispatcher redirecionar = request.getRequestDispatcher("/error/erro.jsp");
				request.setAttribute("msg", e.getMessage());
				redirecionar.forward(request, response);
			}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String mensagem = null;

		try {

			String id = request.getParameter("id");
			String descricao = request.getParameter("descricao");
			String quantidade = request.getParameter("quantidade");
			String dataEntrada = request.getParameter("dataEntrada");
			String unidadeMedida = request.getParameter("unidademedida");

			Produto produto = new Produto();
			produto.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			produto.setDescricao(descricao);
			produto.setQuantidade(Integer.valueOf(quantidade));
			produto.setDataEntrada(Date.valueOf(dataEntrada));
			produto.setUnidadeMedida(unidadeMedida);
			
			
			if (produtoRepository.validarProdutoPelaDescricao(produto.getDescricao()) && produto.getId() == null) {
				mensagem = "Este produto j� est� cadastrado!";
			} else {
				if (produto.isProdutoNovo()) {
					mensagem = "Produto cadastrado com sucesso!";
				}
				
				produto = produtoRepository.gravarProduto(produto);
			}
			
			List<Produto> produtos = produtoRepository.listaDeProdutosCadastrados();
			request.setAttribute("listaDeProdutos", produtos);
			
			request.setAttribute("mensagem", mensagem);
			request.setAttribute("produto", produto);
			RequestDispatcher redirecionaAPagina = request.getRequestDispatcher("principal/cad_produto.jsp");
			redirecionaAPagina.forward(request, response);
			//SETA O OBJETO NA TELA
			request.setAttribute("produto", produto);
			
			

		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("/error/erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
		}
	}

}
