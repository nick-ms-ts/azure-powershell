// <auto-generated>
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for
// license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.
// </auto-generated>

namespace Microsoft.Azure.Management.CosmosDB
{
    using Microsoft.Rest;
    using Microsoft.Rest.Azure;
    using Microsoft.Rest.Serialization;
    using Models;
    using Newtonsoft.Json;
    using System.Collections;
    using System.Collections.Generic;
    using System.Linq;
    using System.Net;
    using System.Net.Http;

    public partial class CosmosDBManagementClient : ServiceClient<CosmosDBManagementClient>, ICosmosDBManagementClient, IAzureClient
    {
        /// <summary>
        /// The base URI of the service.
        /// </summary>
        public System.Uri BaseUri { get; set; }

        /// <summary>
        /// Gets or sets json serialization settings.
        /// </summary>
        public JsonSerializerSettings SerializationSettings { get; private set; }

        /// <summary>
        /// Gets or sets json deserialization settings.
        /// </summary>
        public JsonSerializerSettings DeserializationSettings { get; private set; }

        /// <summary>
        /// Credentials needed for the client to connect to Azure.
        /// </summary>
        public ServiceClientCredentials Credentials { get; private set; }

        /// <summary>
        /// The API version to use for this operation.
        /// </summary>
        public string ApiVersion { get; private set; }

        /// <summary>
        /// The ID of the target subscription.
        /// </summary>
        public string SubscriptionId { get; set; }

        /// <summary>
        /// The preferred language for the response.
        /// </summary>
        public string AcceptLanguage { get; set; }

        /// <summary>
        /// The retry timeout in seconds for Long Running Operations. Default value is
        /// 30.
        /// </summary>
        public int? LongRunningOperationRetryTimeout { get; set; }

        /// <summary>
        /// Whether a unique x-ms-client-request-id should be generated. When set to
        /// true a unique x-ms-client-request-id value is generated and included in
        /// each request. Default is true.
        /// </summary>
        public bool? GenerateClientRequestId { get; set; }

        /// <summary>
        /// Gets the IDatabaseAccountsOperations.
        /// </summary>
        public virtual IDatabaseAccountsOperations DatabaseAccounts { get; private set; }

        /// <summary>
        /// Gets the IOperations.
        /// </summary>
        public virtual IOperations Operations { get; private set; }

        /// <summary>
        /// Gets the IDatabaseOperations.
        /// </summary>
        public virtual IDatabaseOperations Database { get; private set; }

        /// <summary>
        /// Gets the ICollectionOperations.
        /// </summary>
        public virtual ICollectionOperations Collection { get; private set; }

        /// <summary>
        /// Gets the ICollectionRegionOperations.
        /// </summary>
        public virtual ICollectionRegionOperations CollectionRegion { get; private set; }

        /// <summary>
        /// Gets the IDatabaseAccountRegionOperations.
        /// </summary>
        public virtual IDatabaseAccountRegionOperations DatabaseAccountRegion { get; private set; }

        /// <summary>
        /// Gets the IPercentileSourceTargetOperations.
        /// </summary>
        public virtual IPercentileSourceTargetOperations PercentileSourceTarget { get; private set; }

        /// <summary>
        /// Gets the IPercentileTargetOperations.
        /// </summary>
        public virtual IPercentileTargetOperations PercentileTarget { get; private set; }

        /// <summary>
        /// Gets the IPercentileOperations.
        /// </summary>
        public virtual IPercentileOperations Percentile { get; private set; }

        /// <summary>
        /// Gets the ICollectionPartitionRegionOperations.
        /// </summary>
        public virtual ICollectionPartitionRegionOperations CollectionPartitionRegion { get; private set; }

        /// <summary>
        /// Gets the ICollectionPartitionOperations.
        /// </summary>
        public virtual ICollectionPartitionOperations CollectionPartition { get; private set; }

        /// <summary>
        /// Gets the IPartitionKeyRangeIdOperations.
        /// </summary>
        public virtual IPartitionKeyRangeIdOperations PartitionKeyRangeId { get; private set; }

        /// <summary>
        /// Gets the IPartitionKeyRangeIdRegionOperations.
        /// </summary>
        public virtual IPartitionKeyRangeIdRegionOperations PartitionKeyRangeIdRegion { get; private set; }

        /// <summary>
        /// Gets the IGraphResourcesOperations.
        /// </summary>
        public virtual IGraphResourcesOperations GraphResources { get; private set; }

        /// <summary>
        /// Gets the ISqlResourcesOperations.
        /// </summary>
        public virtual ISqlResourcesOperations SqlResources { get; private set; }

        /// <summary>
        /// Gets the IMongoDBResourcesOperations.
        /// </summary>
        public virtual IMongoDBResourcesOperations MongoDBResources { get; private set; }

        /// <summary>
        /// Gets the ITableResourcesOperations.
        /// </summary>
        public virtual ITableResourcesOperations TableResources { get; private set; }

        /// <summary>
        /// Gets the ICassandraResourcesOperations.
        /// </summary>
        public virtual ICassandraResourcesOperations CassandraResources { get; private set; }

        /// <summary>
        /// Gets the IGremlinResourcesOperations.
        /// </summary>
        public virtual IGremlinResourcesOperations GremlinResources { get; private set; }

        /// <summary>
        /// Gets the ILocationsOperations.
        /// </summary>
        public virtual ILocationsOperations Locations { get; private set; }

        /// <summary>
        /// Gets the IDataTransferJobsOperations.
        /// </summary>
        public virtual IDataTransferJobsOperations DataTransferJobs { get; private set; }

        /// <summary>
        /// Gets the ICassandraClustersOperations.
        /// </summary>
        public virtual ICassandraClustersOperations CassandraClusters { get; private set; }

        /// <summary>
        /// Gets the ICassandraDataCentersOperations.
        /// </summary>
        public virtual ICassandraDataCentersOperations CassandraDataCenters { get; private set; }

        /// <summary>
        /// Gets the INotebookWorkspacesOperations.
        /// </summary>
        public virtual INotebookWorkspacesOperations NotebookWorkspaces { get; private set; }

        /// <summary>
        /// Gets the IRestorableDatabaseAccountsOperations.
        /// </summary>
        public virtual IRestorableDatabaseAccountsOperations RestorableDatabaseAccounts { get; private set; }

        /// <summary>
        /// Gets the IRestorableSqlDatabasesOperations.
        /// </summary>
        public virtual IRestorableSqlDatabasesOperations RestorableSqlDatabases { get; private set; }

        /// <summary>
        /// Gets the IRestorableSqlContainersOperations.
        /// </summary>
        public virtual IRestorableSqlContainersOperations RestorableSqlContainers { get; private set; }

        /// <summary>
        /// Gets the IRestorableSqlResourcesOperations.
        /// </summary>
        public virtual IRestorableSqlResourcesOperations RestorableSqlResources { get; private set; }

        /// <summary>
        /// Gets the IRestorableMongodbDatabasesOperations.
        /// </summary>
        public virtual IRestorableMongodbDatabasesOperations RestorableMongodbDatabases { get; private set; }

        /// <summary>
        /// Gets the IRestorableMongodbCollectionsOperations.
        /// </summary>
        public virtual IRestorableMongodbCollectionsOperations RestorableMongodbCollections { get; private set; }

        /// <summary>
        /// Gets the IRestorableMongodbResourcesOperations.
        /// </summary>
        public virtual IRestorableMongodbResourcesOperations RestorableMongodbResources { get; private set; }

        /// <summary>
        /// Gets the IRestorableGremlinDatabasesOperations.
        /// </summary>
        public virtual IRestorableGremlinDatabasesOperations RestorableGremlinDatabases { get; private set; }

        /// <summary>
        /// Gets the IRestorableGremlinGraphsOperations.
        /// </summary>
        public virtual IRestorableGremlinGraphsOperations RestorableGremlinGraphs { get; private set; }

        /// <summary>
        /// Gets the IRestorableGremlinResourcesOperations.
        /// </summary>
        public virtual IRestorableGremlinResourcesOperations RestorableGremlinResources { get; private set; }

        /// <summary>
        /// Gets the IRestorableTablesOperations.
        /// </summary>
        public virtual IRestorableTablesOperations RestorableTables { get; private set; }

        /// <summary>
        /// Gets the IRestorableTableResourcesOperations.
        /// </summary>
        public virtual IRestorableTableResourcesOperations RestorableTableResources { get; private set; }

        /// <summary>
        /// Gets the IServiceOperations.
        /// </summary>
        public virtual IServiceOperations Service { get; private set; }

        /// <summary>
        /// Initializes a new instance of the CosmosDBManagementClient class.
        /// </summary>
        /// <param name='httpClient'>
        /// HttpClient to be used
        /// </param>
        /// <param name='disposeHttpClient'>
        /// True: will dispose the provided httpClient on calling CosmosDBManagementClient.Dispose(). False: will not dispose provided httpClient</param>
        protected CosmosDBManagementClient(HttpClient httpClient, bool disposeHttpClient) : base(httpClient, disposeHttpClient)
        {
            Initialize();
        }

        /// <summary>
        /// Initializes a new instance of the CosmosDBManagementClient class.
        /// </summary>
        /// <param name='handlers'>
        /// Optional. The delegating handlers to add to the http client pipeline.
        /// </param>
        protected CosmosDBManagementClient(params DelegatingHandler[] handlers) : base(handlers)
        {
            Initialize();
        }

        /// <summary>
        /// Initializes a new instance of the CosmosDBManagementClient class.
        /// </summary>
        /// <param name='rootHandler'>
        /// Optional. The http client handler used to handle http transport.
        /// </param>
        /// <param name='handlers'>
        /// Optional. The delegating handlers to add to the http client pipeline.
        /// </param>
        protected CosmosDBManagementClient(HttpClientHandler rootHandler, params DelegatingHandler[] handlers) : base(rootHandler, handlers)
        {
            Initialize();
        }

        /// <summary>
        /// Initializes a new instance of the CosmosDBManagementClient class.
        /// </summary>
        /// <param name='baseUri'>
        /// Optional. The base URI of the service.
        /// </param>
        /// <param name='handlers'>
        /// Optional. The delegating handlers to add to the http client pipeline.
        /// </param>
        /// <exception cref="System.ArgumentNullException">
        /// Thrown when a required parameter is null
        /// </exception>
        protected CosmosDBManagementClient(System.Uri baseUri, params DelegatingHandler[] handlers) : this(handlers)
        {
            if (baseUri == null)
            {
                throw new System.ArgumentNullException("baseUri");
            }
            BaseUri = baseUri;
        }

        /// <summary>
        /// Initializes a new instance of the CosmosDBManagementClient class.
        /// </summary>
        /// <param name='baseUri'>
        /// Optional. The base URI of the service.
        /// </param>
        /// <param name='rootHandler'>
        /// Optional. The http client handler used to handle http transport.
        /// </param>
        /// <param name='handlers'>
        /// Optional. The delegating handlers to add to the http client pipeline.
        /// </param>
        /// <exception cref="System.ArgumentNullException">
        /// Thrown when a required parameter is null
        /// </exception>
        protected CosmosDBManagementClient(System.Uri baseUri, HttpClientHandler rootHandler, params DelegatingHandler[] handlers) : this(rootHandler, handlers)
        {
            if (baseUri == null)
            {
                throw new System.ArgumentNullException("baseUri");
            }
            BaseUri = baseUri;
        }

        /// <summary>
        /// Initializes a new instance of the CosmosDBManagementClient class.
        /// </summary>
        /// <param name='credentials'>
        /// Required. Credentials needed for the client to connect to Azure.
        /// </param>
        /// <param name='handlers'>
        /// Optional. The delegating handlers to add to the http client pipeline.
        /// </param>
        /// <exception cref="System.ArgumentNullException">
        /// Thrown when a required parameter is null
        /// </exception>
        public CosmosDBManagementClient(ServiceClientCredentials credentials, params DelegatingHandler[] handlers) : this(handlers)
        {
            if (credentials == null)
            {
                throw new System.ArgumentNullException("credentials");
            }
            Credentials = credentials;
            if (Credentials != null)
            {
                Credentials.InitializeServiceClient(this);
            }
        }

        /// <summary>
        /// Initializes a new instance of the CosmosDBManagementClient class.
        /// </summary>
        /// <param name='credentials'>
        /// Required. Credentials needed for the client to connect to Azure.
        /// </param>
        /// <param name='httpClient'>
        /// HttpClient to be used
        /// </param>
        /// <param name='disposeHttpClient'>
        /// True: will dispose the provided httpClient on calling CosmosDBManagementClient.Dispose(). False: will not dispose provided httpClient</param>
        /// <exception cref="System.ArgumentNullException">
        /// Thrown when a required parameter is null
        /// </exception>
        public CosmosDBManagementClient(ServiceClientCredentials credentials, HttpClient httpClient, bool disposeHttpClient) : this(httpClient, disposeHttpClient)
        {
            if (credentials == null)
            {
                throw new System.ArgumentNullException("credentials");
            }
            Credentials = credentials;
            if (Credentials != null)
            {
                Credentials.InitializeServiceClient(this);
            }
        }

        /// <summary>
        /// Initializes a new instance of the CosmosDBManagementClient class.
        /// </summary>
        /// <param name='credentials'>
        /// Required. Credentials needed for the client to connect to Azure.
        /// </param>
        /// <param name='rootHandler'>
        /// Optional. The http client handler used to handle http transport.
        /// </param>
        /// <param name='handlers'>
        /// Optional. The delegating handlers to add to the http client pipeline.
        /// </param>
        /// <exception cref="System.ArgumentNullException">
        /// Thrown when a required parameter is null
        /// </exception>
        public CosmosDBManagementClient(ServiceClientCredentials credentials, HttpClientHandler rootHandler, params DelegatingHandler[] handlers) : this(rootHandler, handlers)
        {
            if (credentials == null)
            {
                throw new System.ArgumentNullException("credentials");
            }
            Credentials = credentials;
            if (Credentials != null)
            {
                Credentials.InitializeServiceClient(this);
            }
        }

        /// <summary>
        /// Initializes a new instance of the CosmosDBManagementClient class.
        /// </summary>
        /// <param name='baseUri'>
        /// Optional. The base URI of the service.
        /// </param>
        /// <param name='credentials'>
        /// Required. Credentials needed for the client to connect to Azure.
        /// </param>
        /// <param name='handlers'>
        /// Optional. The delegating handlers to add to the http client pipeline.
        /// </param>
        /// <exception cref="System.ArgumentNullException">
        /// Thrown when a required parameter is null
        /// </exception>
        public CosmosDBManagementClient(System.Uri baseUri, ServiceClientCredentials credentials, params DelegatingHandler[] handlers) : this(handlers)
        {
            if (baseUri == null)
            {
                throw new System.ArgumentNullException("baseUri");
            }
            if (credentials == null)
            {
                throw new System.ArgumentNullException("credentials");
            }
            BaseUri = baseUri;
            Credentials = credentials;
            if (Credentials != null)
            {
                Credentials.InitializeServiceClient(this);
            }
        }

        /// <summary>
        /// Initializes a new instance of the CosmosDBManagementClient class.
        /// </summary>
        /// <param name='baseUri'>
        /// Optional. The base URI of the service.
        /// </param>
        /// <param name='credentials'>
        /// Required. Credentials needed for the client to connect to Azure.
        /// </param>
        /// <param name='rootHandler'>
        /// Optional. The http client handler used to handle http transport.
        /// </param>
        /// <param name='handlers'>
        /// Optional. The delegating handlers to add to the http client pipeline.
        /// </param>
        /// <exception cref="System.ArgumentNullException">
        /// Thrown when a required parameter is null
        /// </exception>
        public CosmosDBManagementClient(System.Uri baseUri, ServiceClientCredentials credentials, HttpClientHandler rootHandler, params DelegatingHandler[] handlers) : this(rootHandler, handlers)
        {
            if (baseUri == null)
            {
                throw new System.ArgumentNullException("baseUri");
            }
            if (credentials == null)
            {
                throw new System.ArgumentNullException("credentials");
            }
            BaseUri = baseUri;
            Credentials = credentials;
            if (Credentials != null)
            {
                Credentials.InitializeServiceClient(this);
            }
        }

        /// <summary>
        /// An optional partial-method to perform custom initialization.
        /// </summary>
        partial void CustomInitialize();
        /// <summary>
        /// Initializes client properties.
        /// </summary>
        private void Initialize()
        {
            DatabaseAccounts = new DatabaseAccountsOperations(this);
            Operations = new Operations(this);
            Database = new DatabaseOperations(this);
            Collection = new CollectionOperations(this);
            CollectionRegion = new CollectionRegionOperations(this);
            DatabaseAccountRegion = new DatabaseAccountRegionOperations(this);
            PercentileSourceTarget = new PercentileSourceTargetOperations(this);
            PercentileTarget = new PercentileTargetOperations(this);
            Percentile = new PercentileOperations(this);
            CollectionPartitionRegion = new CollectionPartitionRegionOperations(this);
            CollectionPartition = new CollectionPartitionOperations(this);
            PartitionKeyRangeId = new PartitionKeyRangeIdOperations(this);
            PartitionKeyRangeIdRegion = new PartitionKeyRangeIdRegionOperations(this);
            GraphResources = new GraphResourcesOperations(this);
            SqlResources = new SqlResourcesOperations(this);
            MongoDBResources = new MongoDBResourcesOperations(this);
            TableResources = new TableResourcesOperations(this);
            CassandraResources = new CassandraResourcesOperations(this);
            GremlinResources = new GremlinResourcesOperations(this);
            Locations = new LocationsOperations(this);
            DataTransferJobs = new DataTransferJobsOperations(this);
            CassandraClusters = new CassandraClustersOperations(this);
            CassandraDataCenters = new CassandraDataCentersOperations(this);
            NotebookWorkspaces = new NotebookWorkspacesOperations(this);
            RestorableDatabaseAccounts = new RestorableDatabaseAccountsOperations(this);
            RestorableSqlDatabases = new RestorableSqlDatabasesOperations(this);
            RestorableSqlContainers = new RestorableSqlContainersOperations(this);
            RestorableSqlResources = new RestorableSqlResourcesOperations(this);
            RestorableMongodbDatabases = new RestorableMongodbDatabasesOperations(this);
            RestorableMongodbCollections = new RestorableMongodbCollectionsOperations(this);
            RestorableMongodbResources = new RestorableMongodbResourcesOperations(this);
            RestorableGremlinDatabases = new RestorableGremlinDatabasesOperations(this);
            RestorableGremlinGraphs = new RestorableGremlinGraphsOperations(this);
            RestorableGremlinResources = new RestorableGremlinResourcesOperations(this);
            RestorableTables = new RestorableTablesOperations(this);
            RestorableTableResources = new RestorableTableResourcesOperations(this);
            Service = new ServiceOperations(this);
            BaseUri = new System.Uri("https://management.azure.com");
            ApiVersion = "2022-08-15-preview";
            AcceptLanguage = "en-US";
            LongRunningOperationRetryTimeout = 30;
            GenerateClientRequestId = true;
            SerializationSettings = new JsonSerializerSettings
            {
                Formatting = Newtonsoft.Json.Formatting.Indented,
                DateFormatHandling = Newtonsoft.Json.DateFormatHandling.IsoDateFormat,
                DateTimeZoneHandling = Newtonsoft.Json.DateTimeZoneHandling.Utc,
                NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore,
                ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Serialize,
                ContractResolver = new ReadOnlyJsonContractResolver(),
                Converters = new List<JsonConverter>
                    {
                        new Iso8601TimeSpanConverter()
                    }
            };
            SerializationSettings.Converters.Add(new TransformationJsonConverter());
            DeserializationSettings = new JsonSerializerSettings
            {
                DateFormatHandling = Newtonsoft.Json.DateFormatHandling.IsoDateFormat,
                DateTimeZoneHandling = Newtonsoft.Json.DateTimeZoneHandling.Utc,
                NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore,
                ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Serialize,
                ContractResolver = new ReadOnlyJsonContractResolver(),
                Converters = new List<JsonConverter>
                    {
                        new Iso8601TimeSpanConverter()
                    }
            };
            SerializationSettings.Converters.Add(new PolymorphicSerializeJsonConverter<BackupPolicy>("type"));
            DeserializationSettings.Converters.Add(new PolymorphicDeserializeJsonConverter<BackupPolicy>("type"));
            SerializationSettings.Converters.Add(new PolymorphicSerializeJsonConverter<DataTransferDataSourceSink>("component"));
            DeserializationSettings.Converters.Add(new PolymorphicDeserializeJsonConverter<DataTransferDataSourceSink>("component"));
            SerializationSettings.Converters.Add(new PolymorphicSerializeJsonConverter<ServiceResourceProperties>("serviceType"));
            DeserializationSettings.Converters.Add(new PolymorphicDeserializeJsonConverter<ServiceResourceProperties>("serviceType"));
            CustomInitialize();
            DeserializationSettings.Converters.Add(new TransformationJsonConverter());
            DeserializationSettings.Converters.Add(new CloudErrorJsonConverter());
        }
    }
}
