# 🛒 电商数据分析项目

> 跨国零售客户行为分析与价值挖掘系统，涵盖数据清洗、复购率分析、RFM分层、产品聚类、客户分群及分类器发全流程。

---
## 项目亮点

### 1. 核心分析能力
- **复购率趋势分析**：计算月度/季度复购率与环比增长（SQL）
- **动态RFM分层**：Tableau构建可交互客户价值看板
- **产品智能分类**：TF-IDF + K-Means聚类（6类）与词云分析
- **客户价值分群**：MiniBatchK-Means划分7类客户群体,Matplotlib/Seaborn可视化，
  定位超级VIP客户（0.77%群体贡献32%营收），设计定制化营销策略。
### 2. 技术实现
- E_commerce_Customer_Analytics.ipynb
### 3. 关键成果
- 识别0.77%超高价值客户（年均消费$67K+）
- 梯度提升+投票分类器来预测客户类型实现84.46%预测准确率

---
## 📑 项目目录

- [项目简介（About the Dataset）](#项目简介about-the-dataset)
- [数据清洗（Data Cleaning）](#数据清洗data-cleaning)
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
- [⚖模型对比与最终选择（Model Comparison & Final Result）](#模型对比与最终选择model-comparison--final-result)
- [结论与未来方向（Conclusion & Future Work）](#结论与未来方向conclusion--future-work)

---

## 项目简介（About the Dataset）

本项目使用电商平台的客户交易数据，旨在深入分析用户行为，并通过机器学习模型进行客户预测与分类。

- 数据量约：30,000+ 条订单记录
- 包含字段：客户 ID、下单时间、下单金额、退货状态、地理位置等
- 工具与技术栈：  
  - Python（Pandas, Scikit-learn, XGBoost, KMeans）  
  - SQL（窗口函数 + 分组分析）  
  - Tableau（动态图表 + 地图联动）  
  - Google Colab（模型训练）

---

## 数据清洗（Data Cleaning）

- 清洗缺失值、异常值、格式错误
- 构建新的特征字段：复购标记、交易周期、是否退货等
- 标准化金额、时间等字段，准备建模所需数据结构

---

## 用户复购分析（Repurchase Rate Analysis）

- 计算整体复购率（一次及以上）
- 每月复购率趋势折线图 📈
- 环比增长（MoM）、季度增长（QoQ）分析 📊

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

- 基于 RFM 值进行标准化 + KMeans 聚类
- 输出客户分层标签：高活跃、高价值、沉睡用户等
- 可视化不同客户群体特征分布图

---

## 分类器建模（Customer Classification Model）

> 使用多个模型进行客户是否复购的预测建模任务：

- 模型尝试：
  - Logistic Regression
  - Decision Tree
  - Random Forest
  - XGBoost
- 指标评估：
  - Accuracy, Precision, Recall, F1-score
- 最佳模型结果：**Random Forest / XGBoost**
  - 准确率最高可达 **84.46%**

---

## 模型对比与最终选择（Model Comparison & Final Result）

| 模型           | Accuracy | F1-Score |
|----------------|----------|----------|
| Logistic Reg.  | 75.32%   | 74.12%   |
| Decision Tree  | 81.22%   | 80.43%   |
| Random Forest  | **84.46%** | **83.91%** |
| XGBoost        | 83.89%   | 83.10%   |

---

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

