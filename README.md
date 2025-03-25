# 电商数据分析项目

> 跨国零售客户行为分析与价值挖掘系统，涵盖数据清洗、复购率分析、RFM分层、产品聚类、客户分群及分类器全流程。

---
## 项目亮点

### 1. 核心分析能力
- **复购率趋势分析**：计算月度/季度复购率与环比增长（SQL）
- **动态RFM分层**：Tableau构建可交互客户价值看板
- **产品智能分类**：TF-IDF + K-Means聚类（6类）与词云分析
- **客户价值分群**：结合产品分类特征基于MiniBatchK-Means划分7类客户群体，
  通过Matplotlib/Seaborn可视化，定位超级VIP客户（0.77%群体贡献32%营收），设计定制化营销策略。
### 2. 技术实现
- E_commerce_Customer_Analytics.ipynb
### 3. 关键成果
- 识别0.77%超高价值客户（年均消费$67K+），并设计定制化营销策略。
- 梯度提升+投票分类器来预测客户类型实现84.46%预测准确率

---
## 项目目录

- [项目简介（About the Dataset）](#项目简介about-the-dataset)
- [数据清洗（Data Cleaning）](#数据清洗data-cleaning)
- [数据探索（Data Understanding）](#数据探索Data-Understanding)
  - [用户复购分析（Repurchase Rate Analysis）](#用户复购分析repurchase-rate-analysis)
    - [整体复购率](#整体复购率)
    - [每月复购率](#每月复购率)
    - [环比增长 MoM](#环比增长-mom)
    - [季度环比增长 QoQ](#季度环比增长-qoq)
  - [Tableau 可视化分析](#tableau-可视化分析)
    - [每月复购率折线图](#每月复购率折线图)
    - [RFM 客户价值分析](#rfm-客户价值分析)
    - [动态 RFM 分层](#动态-rfm-分层)
    - [客户地理分布地图](#客户地理分布地图)
- [产品聚类分析（Product Clustering）](#产品聚类分析product-clustering)
- [客户聚类分析（Customer Segmentation）](#客户聚类分析customer-segmentation)
- [分类器建模（Customer Classification Model）](#分类器建模customer-classification-model)
- [模型对比与最终选择（Model Comparison & Final Result）](#模型对比与最终选择model-comparison--final-result)
- [结论与未来方向（Conclusion & Future Work）](#结论与未来方向conclusion--future-work)

---

## 项目简介（About the Dataset）

本项目使用电商平台的客户交易数据，旨在深入分析用户行为，并通过机器学习模型来预测客户类型与分类。

- 数据量约：500,000+ 条订单记录
- 包含字段：订单号、商品 ID、商品描述、下单数量、下单时间、商品单价、客户 ID、地理位置
- 工具与技术栈： 
  - Python (Pandas, Scikit-learn, Matplotlib/Seaborn)
  - SQL（窗口函数 + 分组分析）  
  - Tableau（动态图表 + 地图联动）  
  - Google Colab（模型训练）

---

## 数据清洗（Data Cleaning）

- 清洗缺失值、异常值、格式错误
- 构建新的特征字段：订单总金额
- 标准化金额、时间等字段，准备建模所需数据结构

---
## 数据探索（Data Understanding）
- 在数据探索阶段，我们使用 SQL 查询 来分析客户的购买行为模式，特别关注 复购率（Repurchase Rate） 和 增长趋势（MoM、QoQ）。
---
## 用户复购分析（Repurchase Rate Analysis）

- 计算整体复购率（一次及以上）
- 每月复购率趋势折线图 
- 环比增长（MoM）、季度增长（QoQ）分析 

---

## Tableau 可视化分析

- **每月复购率折线图**
- **RFM 客户分层图（高价值用户识别）**
- **动态 RFM 分布切换（R/F/M 指标维度）**
- **客户地理分布地图**

---

## 产品聚类分析（Product Clustering）

- 通过销量、复购率、退货率进行 KMeans 聚类
- 辨别高价值产品、流行款与退货高风险产品
- 图形展示聚类分布与中心点趋势

---

## 客户聚类分析（Customer Segmentation）

- 基于商品分类特征 + KMeans 聚类
- 输出客户分层标签：普通客户、复购客户、高价值客户、超级 VIP 客户等
- 可视化不同客户群体特征分布图

---

## 分类器建模（Customer Classification Model）

> 使用多个模型进行客户是否复购的预测建模任务：

- 模型尝试：
  - 逻辑回归（Logistic Regression）
  - K 近邻（KNN）
  - 决策树（Decision Tree）
  - 随机森林（Random Forest）
  - 梯度提升（Gradient Boosting）
  - AdaBoost
  - 投票分类器（Voting Classifier）

---

## 模型对比与最终选择（Model Comparison & Final Result）

| 模型           | 交叉验证准确率 | 测试集准确率 |
|----------------|----------|----------|
| 逻辑回归 | 0.6603   | 0.6663   |
|KNN  | 0.7116   | 0.7211   |
| 决策树  | 0.7925 | 0.7829 |
| 随机森林        | 0.8248   | 0.8229   |
| AdaBoost | 0.6446   | 0.6537   |
| 梯度提升 | 0.8381   | 0.8389   |
---
| 投票分类器模型选择          | 权重 | 测试集准确率 |
|---------------------------------|----------|----------|
| 随机森林，梯度提升，KNN，逻辑回归 | 2, 3, 1, 0.5   | 0.8446   |
| 随机森林，梯度提升，KNN，逻辑回归 | 3, 3, 1, 1   | 0.8411  |
| 随机森林，梯度提升，KNN，逻辑回归 | 2, 2, 2, 1   | 0.8377   |
## 结论与未来方向（Conclusion & Future Work）

- 本项目实现了从原始数据到业务洞察、可视化和机器学习预测的全流程
- 后续可继续优化方向：
  - 添加深度学习模型
  - 优化特征工程与数据维度
  - 接入实时数据库 + 自动化报表系统
  - 部署模型至云端用于线上服务

---

## 项目链接

- ⚙️ **Colab Notebook（可运行）:[https://colab.research.google.com/drive/1vRTaGIhQDwMnMSqAsJXhF77Fmis4dejV?usp=sharing]

---

## 🙋‍♀️ 作者介绍

> 本项目由 [你的名字] 完成，具有数据分析背景 + 艺术创作经验，擅长将数据洞察与美学设计结合，提升商业决策效率与客户体验。

---

