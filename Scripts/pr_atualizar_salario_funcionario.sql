create or replace procedure pr_atualizar_salario_funcionario (p_cd_funcionario number, p_vl_salario number, o_erro out varchar) is
    v_dummy number;
begin
    select 1 into v_dummy from teste.tb_funcionario fun 
    where fun.cd_funcionario = p_cd_funcionario;
    --
    update tb_funcionario fun set
    fun.vl_salario = p_vl_salario 
    where fun.cd_funcionario = p_cd_funcionario;
exception
    when no_data_found then
        o_erro := 'Nenhum funcionário com este código foi localizado';
    when others then 
        o_erro := 'Ocorreu um erro: ' || sqlerrm;
end;