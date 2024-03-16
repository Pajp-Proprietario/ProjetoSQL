Create or replace package pk_gestao_vendas as
    procedure pr_atualizar_precos (p_cd_categoria number, p_vl_percentual number, o_erro out varchar2);
    function fn_qtd_pedidos (p_cd_cliente number) return number;
    function fn_total_vendas(p_mes number, p_ano number) return number;
    function fn_qtd_unidades_vendidas (p_id_produto number, p_dt_inicio date, p_dt_fim date) return number;
end;
/
Create or replace package body pk_gestao_vendas as
    /*1 - Crie uma função que receba o ID de um cliente e retorne o total de pedidos feitos por esse cliente.*/
    function fn_qtd_pedidos (p_cd_cliente number) return number is
        v_qtd_pedidos number;
    begin
        select count(1) 
        into v_qtd_pedidos 
        from teste.tb_pedido ped 
        where ped.id_cli = p_cd_cliente;
        --
        return v_qtd_pedidos;
    end fn_qtd_pedidos;
    
    /* 2 - Escreva um procedimento que atualize o preço de todos os produtos em 
    uma determinada categoria para um novo valor fornecido como entrada.*/
    procedure pr_atualizar_precos (p_cd_categoria number, p_vl_percentual number, o_erro out varchar2) is
        v_qtd number;
    begin
        select count(1) into v_qtd 
        from teste.tb_produto prod 
        where prod.id_catprod = p_cd_categoria;
        --
        if v_qtd = 0 then
            o_erro := 'Não foram localizados produtos para a categoria informada!';      
            Return;
        end if;
        --
        update teste.tb_produto set
        vl_produto = vl_produto + (vl_produto * (p_vl_percentual / 100))
        where id_catprod = p_cd_categoria;
        --
    exception
        when others then
            o_erro := sqlerrm;
    end pr_atualizar_precos;
    
    /*3 - Desenvolva um bloco anônimo que calcule o total de vendas em um determinado mês e ano. (vou fazer em uma funcion mesmo)*/
    function fn_total_vendas(p_mes number, p_ano number) return number is
        v_vl_total number;
    begin
        select sum(ped.vl_total_pedido) 
        into v_vl_total 
        from teste.vw_pedidos ped
        where extract (month from ped.dt_pedido) = p_mes
        and extract (year from ped.dt_pedido) = p_ano;
        --
        return v_vl_total;
    end fn_total_vendas;
    
    /*4 - Crie uma função que receba o ID de um produto e retorne o total de unidades vendidas desse produto em um intervalo de datas específico.*/
    function fn_qtd_unidades_vendidas (p_id_produto number, p_dt_inicio date, p_dt_fim date) return number is
        v_qtd_unidades_vendidas number;
    begin
        select count(1) into v_qtd_unidades_vendidas from teste.tb_item_pedido itemped inner join teste.tb_pedido ped
        on (itemped.id_ped = ped.id)
        where itemped.id_prod = p_id_produto
        and ped.dt_pedido between p_dt_inicio and p_dt_fim;
        --
        return v_qtd_unidades_vendidas;
    end fn_qtd_unidades_vendidas;
end;