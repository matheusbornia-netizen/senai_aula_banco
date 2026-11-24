-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 18/11/2026 às 09:42
-- Versão do servidor: 8.0.42-0ubuntu0.24.04.1
-- Versão do PHP: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `senai_aula`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `componentes_maq`
--

CREATE TABLE `componentes_maq` (
  `id_componente` int NOT NULL,
  `id_maquina` int DEFAULT NULL,
  `nome_componente` varchar(100) DEFAULT NULL,
  `horas_uso_acumulado` int DEFAULT NULL,
  `limite_hora_alerta` int DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `estoque_pecas`
--

CREATE TABLE `estoque_pecas` (
  `id_pecas` int NOT NULL,
  `codigo_part_number` varchar(50) DEFAULT NULL,
  `descricao` varchar(150) DEFAULT NULL,
  `qtd_estoque` int DEFAULT NULL,
  `preco_unitario` decimal(10,2) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `historico_sensores`
--

CREATE TABLE `historico_sensores` (
  `id_leitura` int NOT NULL,
  `id_ordem` int DEFAULT NULL,
  `temperatura_medida` decimal(5,2) DEFAULT NULL,
  `vibracao_mm_s` decimal(5,2) DEFAULT NULL,
  `data_hora_leitura` datetime DEFAULT NULL,
  `prompt_geracao_ia` varchar(100) DEFAULT 'gerado_por_llm'
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `linhas_producao`
--

CREATE TABLE `linhas_producao` (
  `id_linha` int NOT NULL,
  `id_unidade` int DEFAULT NULL,
  `nome_linha` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `MAQUINAS_SENAI`
--

CREATE TABLE `MAQUINAS_SENAI` (
  `id_maquina` int NOT NULL,
  `id_linha` int DEFAULT NULL,
  `id_tipo` int DEFAULT NULL,
  `tag_patrimonio` varchar(30) DEFAULT NULL,
  `data_aquisicao` date DEFAULT NULL,
  `status_operacao` varchar(20) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ordens_servico`
--

CREATE TABLE `ordens_servico` (
  `id_ordem` int NOT NULL,
  `id_maquina` int DEFAULT NULL,
  `id_tecnico` int DEFAULT NULL,
  `data_abertura` datetime DEFAULT NULL,
  `tipo_manutencao` varchar(20) DEFAULT NULL,
  `status_os` varchar(20) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pecas_os`
--

CREATE TABLE `pecas_os` (
  `id_ordem` int NOT NULL,
  `id_pecas` int NOT NULL,
  `qtd_estoque` int DEFAULT NULL,
  `preco_aplicado` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tecnicos`
--

CREATE TABLE `tecnicos` (
  `id_tecnico` int NOT NULL,
  `nome_tecnico` varchar(100) DEFAULT NULL,
  `especialidade` varchar(50) DEFAULT NULL,
  `nivel_certificado` varchar(30) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `TIPOS_MAQUINA`
--

CREATE TABLE `TIPOS_MAQUINA` (
  `id_tipo` int NOT NULL,
  `nome_tipo` varchar(50) DEFAULT NULL,
  `horas_revisao_padrao` int DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `unidade_senai`
--

CREATE TABLE `unidade_senai` (
  `id_unidade` int NOT NULL,
  `nome_unidade` varchar(255) DEFAULT NULL,
  `cidade` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `componentes_maq`
--
ALTER TABLE `componentes_maq`
  ADD PRIMARY KEY (`id_componente`),
  ADD KEY `fk_id_maquina` (`id_maquina`);

--
-- Índices de tabela `estoque_pecas`
--
ALTER TABLE `estoque_pecas`
  ADD PRIMARY KEY (`id_pecas`),
  ADD UNIQUE KEY `codigo_part_number` (`codigo_part_number`);

--
-- Índices de tabela `historico_sensores`
--
ALTER TABLE `historico_sensores`
  ADD PRIMARY KEY (`id_leitura`),
  ADD KEY `fk_historico_ordem` (`id_ordem`);

--
-- Índices de tabela `linhas_producao`
--
ALTER TABLE `linhas_producao`
  ADD PRIMARY KEY (`id_linha`),
  ADD KEY `fk_linha_unidade` (`id_unidade`);

--
-- Índices de tabela `MAQUINAS_SENAI`
--
ALTER TABLE `MAQUINAS_SENAI`
  ADD PRIMARY KEY (`id_maquina`),
  ADD UNIQUE KEY `tag_patrimonio` (`tag_patrimonio`),
  ADD KEY `fk_maquina_linha` (`id_linha`),
  ADD KEY `fk_maquina_tipo` (`id_tipo`);

--
-- Índices de tabela `ordens_servico`
--
ALTER TABLE `ordens_servico`
  ADD PRIMARY KEY (`id_ordem`),
  ADD KEY `fk_os_maquina` (`id_maquina`),
  ADD KEY `fk_os_tecnico` (`id_tecnico`);

--
-- Índices de tabela `pecas_os`
--
ALTER TABLE `pecas_os`
  ADD PRIMARY KEY (`id_ordem`,`id_pecas`),
  ADD KEY `fk_pecas_estoque` (`id_pecas`);

--
-- Índices de tabela `tecnicos`
--
ALTER TABLE `tecnicos`
  ADD PRIMARY KEY (`id_tecnico`);

--
-- Índices de tabela `TIPOS_MAQUINA`
--
ALTER TABLE `TIPOS_MAQUINA`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Índices de tabela `unidade_senai`
--
ALTER TABLE `unidade_senai`
  ADD PRIMARY KEY (`id_unidade`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `componentes_maq`
--
ALTER TABLE `componentes_maq`
  MODIFY `id_componente` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `estoque_pecas`
--
ALTER TABLE `estoque_pecas`
  MODIFY `id_pecas` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `historico_sensores`
--
ALTER TABLE `historico_sensores`
  MODIFY `id_leitura` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `linhas_producao`
--
ALTER TABLE `linhas_producao`
  MODIFY `id_linha` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `MAQUINAS_SENAI`
--
ALTER TABLE `MAQUINAS_SENAI`
  MODIFY `id_maquina` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `ordens_servico`
--
ALTER TABLE `ordens_servico`
  MODIFY `id_ordem` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tecnicos`
--
ALTER TABLE `tecnicos`
  MODIFY `id_tecnico` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `TIPOS_MAQUINA`
--
ALTER TABLE `TIPOS_MAQUINA`
  MODIFY `id_tipo` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `unidade_senai`
--
ALTER TABLE `unidade_senai`
  MODIFY `id_unidade` int NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `componentes_maq`
--
ALTER TABLE `componentes_maq`
  ADD CONSTRAINT `fk_id_maquina` FOREIGN KEY (`id_maquina`) REFERENCES `MAQUINAS_SENAI` (`id_maquina`);

--
-- Restrições para tabelas `historico_sensores`
--
ALTER TABLE `historico_sensores`
  ADD CONSTRAINT `fk_historico_ordem` FOREIGN KEY (`id_ordem`) REFERENCES `ordens_servico` (`id_ordem`);

--
-- Restrições para tabelas `linhas_producao`
--
ALTER TABLE `linhas_producao`
  ADD CONSTRAINT `fk_linha_unidade` FOREIGN KEY (`id_unidade`) REFERENCES `unidade_senai` (`id_unidade`);

--
-- Restrições para tabelas `MAQUINAS_SENAI`
--
ALTER TABLE `MAQUINAS_SENAI`
  ADD CONSTRAINT `fk_maquina_linha` FOREIGN KEY (`id_linha`) REFERENCES `linhas_producao` (`id_linha`),
  ADD CONSTRAINT `fk_maquina_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `TIPOS_MAQUINA` (`id_tipo`);

--
-- Restrições para tabelas `ordens_servico`
--
ALTER TABLE `ordens_servico`
  ADD CONSTRAINT `fk_os_maquina` FOREIGN KEY (`id_maquina`) REFERENCES `MAQUINAS_SENAI` (`id_maquina`),
  ADD CONSTRAINT `fk_os_tecnico` FOREIGN KEY (`id_tecnico`) REFERENCES `tecnicos` (`id_tecnico`);

--
-- Restrições para tabelas `pecas_os`
--
ALTER TABLE `pecas_os`
  ADD CONSTRAINT `fk_pecas_estoque` FOREIGN KEY (`id_pecas`) REFERENCES `estoque_pecas` (`id_pecas`),
  ADD CONSTRAINT `fk_pecas_ordem` FOREIGN KEY (`id_ordem`) REFERENCES `ordens_servico` (`id_ordem`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
