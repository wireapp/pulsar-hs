{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DeriveGeneric              #-}

module Pulsar.Admin.Types (
  AllocatorStats (..),
  AuthPolicies (..),
  AuthenticationDataSource (..),
  AuthenticationParameters (..),
  AutoFailoverPolicyData (..),
  AutoSubscriptionCreationOverride (..),
  AutoSubscriptionCreationOverrideImpl (..),
  AutoTopicCreationOverride (..),
  AutoTopicCreationOverrideImpl (..),
  BacklogQuota (..),
  BacklogQuotaImpl (..),
  BitSet (..),
  BookieAffinityGroupData (..),
  BookieAffinityGroupDataImpl (..),
  BookieInfo (..),
  BookiesClusterInfo (..),
  BrokerInfo (..),
  BrokerNamespaceIsolationData (..),
  BundlesData (..),
  BundlesDataImpl (..),
  Certificate (..),
  ClusterData (..),
  ClusterUrl (..),
  CompactionStats (..),
  CompactionStatsImpl (..),
  CompletableFuture (..),
  CompletableFutureClusterData (..),
  CompletableFutureListSchemaAndMetadata (..),
  CompletableFutureLong (..),
  CompletableFuturePairBooleanSchemaCompatibilityStrategy (..),
  CompletableFuturePartitionedTopicMetadata (..),
  CompletableFutureResourceQuota (..),
  CompletableFutureSchemaAndMetadata (..),
  CompletableFutureSchemaMetadata (..),
  CompletableFutureSchemaVersion (..),
  CompletableFutureVoid (..),
  ConnectorDefinition (..),
  ConsumerStats (..),
  CursorDetails (..),
  CursorInfo (..),
  CursorStats (..),
  DelayedDeliveryPolicies (..),
  DeleteSchemaResponse (..),
  DispatchRate (..),
  DispatchRateImpl (..),
  DrainingHash (..),
  EntryFilters (..),
  FailureDomain (..),
  FunctionInstanceStatsData (..),
  FunctionInstanceStatsDataBase (..),
  Functions (..),
  FunctionsV2 (..),
  FunctionsV2WorkerService (..),
  FunctionsWorkerService (..),
  GetAllVersionsSchemaResponse (..),
  GetSchemaResponse (..),
  InactiveTopicPolicies (..),
  InternalConfigurationData (..),
  IsCompatibilityResponse (..),
  KubernetesContainerFactory (..),
  LedgerDetails (..),
  LedgerInfo (..),
  LoadReport (..),
  LongRunningProcessStatus (..),
  LongSchemaVersion (..),
  ManagedLedgerInfo (..),
  MemoryLimit (..),
  MessageIdAdv (..),
  MessageRangeInfo (..),
  Metrics (..),
  NamespaceBundleStats (..),
  NamespaceIsolationData (..),
  NamespaceOwnershipStatus (..),
  NonPersistentPartitionedTopicStatsImpl (..),
  NonPersistentPublisherStats (..),
  NonPersistentReplicatorStats (..),
  NonPersistentSubscriptionStats (..),
  NonPersistentTopicStatsImpl (..),
  OffloadPolicies (..),
  OffloadPoliciesImpl (..),
  OffloadProcessStatus (..),
  PartitionedManagedLedgerInfo (..),
  PartitionedTopicInternalStats (..),
  PartitionedTopicMetadata (..),
  PartitionedTopicStatsImpl (..),
  PendingBookieOpsStats (..),
  PersistencePolicies (..),
  PersistentOfflineTopicStats (..),
  PersistentTopicInternalStats (..),
  PersistentTopicStats (..),
  Policies (..),
  PoolArenaStats (..),
  PoolChunkListStats (..),
  PoolChunkStats (..),
  PoolSubpageStats (..),
  PositionInfo (..),
  PostSchemaPayload (..),
  PostSchemaResponse (..),
  ProcessContainerFactory (..),
  PublicKey (..),
  PublishRate (..),
  PublisherStats (..),
  RawBookieInfo (..),
  ReplicatorStats (..),
  ResetCursorData (..),
  ResourceDescription (..),
  ResourceGroup (..),
  ResourceQuota (..),
  ResourceUnit (..),
  ResourceUsage (..),
  Resources (..),
  RetentionPolicies (..),
  Sinks (..),
  SinksWorkerService (..),
  Sources (..),
  SourcesWorkerService (..),
  SubscribeRate (..),
  SubscriptionStats (..),
  SystemResourceUsage (..),
  TenantInfo (..),
  ThreadContainerFactory (..),
  TopicHashPositions (..),
  TopicStats (..),
  WorkerConfig (..),
  WorkerFunctionInstanceStats (..),
  WorkerInfo (..),
  WorkerService (..),
  ) where

import Data.List (stripPrefix)
import Data.Maybe (fromMaybe)
import Data.Aeson (Value, FromJSON(..), ToJSON(..), genericToJSON, genericParseJSON)
import Data.Aeson.Types (Options(..), defaultOptions)
import Data.Text (Text)
import Data.Time hiding (TimeZone)
import qualified Data.Char as Char
import qualified Data.Text as T
import qualified Data.Map as Map
import GHC.Generics (Generic)
import Data.Function ((&))


-- | 
data AllocatorStats = AllocatorStats
  { allocatorStatsDirectArenas :: Maybe [PoolArenaStats] -- ^ 
  , allocatorStatsHeapArenas :: Maybe [PoolArenaStats] -- ^ 
  , allocatorStatsNormalCacheSize :: Maybe Int -- ^ 
  , allocatorStatsNumDirectArenas :: Maybe Int -- ^ 
  , allocatorStatsNumHeapArenas :: Maybe Int -- ^ 
  , allocatorStatsNumThreadLocalCaches :: Maybe Int -- ^ 
  , allocatorStatsSmallCacheSize :: Maybe Int -- ^ 
  , allocatorStatsUsedDirectMemory :: Maybe Integer -- ^ 
  , allocatorStatsUsedHeapMemory :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON AllocatorStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "allocatorStats")
instance ToJSON AllocatorStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "allocatorStats")


-- | 
data AuthPolicies = AuthPolicies
  { authPoliciesNamespaceAuthentication :: Maybe (Map.Map String [Text]) -- ^ 
  , authPoliciesSubscriptionAuthentication :: Maybe (Map.Map String [Text]) -- ^ 
  , authPoliciesTopicAuthentication :: Maybe (Map.Map String (Map.Map String [Text])) -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON AuthPolicies where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "authPolicies")
instance ToJSON AuthPolicies where
  toJSON = genericToJSON (removeFieldLabelPrefix False "authPolicies")


-- | 
data AuthenticationDataSource = AuthenticationDataSource
  { authenticationDataSourceCommandData :: Maybe Text -- ^ 
  , authenticationDataSourceHttpAuthType :: Maybe Text -- ^ 
  , authenticationDataSourcePeerAddress :: Maybe Value -- ^ 
  , authenticationDataSourceSubscription :: Maybe Text -- ^ 
  , authenticationDataSourceTlsCertificates :: Maybe [Certificate] -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON AuthenticationDataSource where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "authenticationDataSource")
instance ToJSON AuthenticationDataSource where
  toJSON = genericToJSON (removeFieldLabelPrefix False "authenticationDataSource")


-- | 
data AuthenticationParameters = AuthenticationParameters
  { authenticationParametersClientAuthenticationDataSource :: Maybe AuthenticationDataSource -- ^ 
  , authenticationParametersClientRole :: Maybe Text -- ^ 
  , authenticationParametersOriginalPrincipal :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON AuthenticationParameters where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "authenticationParameters")
instance ToJSON AuthenticationParameters where
  toJSON = genericToJSON (removeFieldLabelPrefix False "authenticationParameters")


-- | 
data AutoFailoverPolicyData = AutoFailoverPolicyData
  { autoFailoverPolicyDataParameters :: Maybe (Map.Map String Text) -- ^ 
  , autoFailoverPolicyDataPolicyType :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON AutoFailoverPolicyData where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "autoFailoverPolicyData")
instance ToJSON AutoFailoverPolicyData where
  toJSON = genericToJSON (removeFieldLabelPrefix False "autoFailoverPolicyData")


-- | 
data AutoSubscriptionCreationOverride = AutoSubscriptionCreationOverride
  { autoSubscriptionCreationOverrideAllowAutoSubscriptionCreation :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON AutoSubscriptionCreationOverride where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "autoSubscriptionCreationOverride")
instance ToJSON AutoSubscriptionCreationOverride where
  toJSON = genericToJSON (removeFieldLabelPrefix False "autoSubscriptionCreationOverride")


-- | 
data AutoSubscriptionCreationOverrideImpl = AutoSubscriptionCreationOverrideImpl
  { autoSubscriptionCreationOverrideImplAllowAutoSubscriptionCreation :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON AutoSubscriptionCreationOverrideImpl where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "autoSubscriptionCreationOverrideImpl")
instance ToJSON AutoSubscriptionCreationOverrideImpl where
  toJSON = genericToJSON (removeFieldLabelPrefix False "autoSubscriptionCreationOverrideImpl")


-- | 
data AutoTopicCreationOverride = AutoTopicCreationOverride
  { autoTopicCreationOverrideAllowAutoTopicCreation :: Maybe Bool -- ^ 
  , autoTopicCreationOverrideDefaultNumPartitions :: Maybe Int -- ^ 
  , autoTopicCreationOverrideTopicType :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON AutoTopicCreationOverride where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "autoTopicCreationOverride")
instance ToJSON AutoTopicCreationOverride where
  toJSON = genericToJSON (removeFieldLabelPrefix False "autoTopicCreationOverride")


-- | 
data AutoTopicCreationOverrideImpl = AutoTopicCreationOverrideImpl
  { autoTopicCreationOverrideImplAllowAutoTopicCreation :: Maybe Bool -- ^ 
  , autoTopicCreationOverrideImplDefaultNumPartitions :: Maybe Int -- ^ 
  , autoTopicCreationOverrideImplTopicType :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON AutoTopicCreationOverrideImpl where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "autoTopicCreationOverrideImpl")
instance ToJSON AutoTopicCreationOverrideImpl where
  toJSON = genericToJSON (removeFieldLabelPrefix False "autoTopicCreationOverrideImpl")


-- | 
data BacklogQuota = BacklogQuota
  { backlogQuotaLimit :: Maybe Integer -- ^ 
  , backlogQuotaLimitSize :: Maybe Integer -- ^ 
  , backlogQuotaLimitTime :: Maybe Int -- ^ 
  , backlogQuotaPolicy :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON BacklogQuota where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "backlogQuota")
instance ToJSON BacklogQuota where
  toJSON = genericToJSON (removeFieldLabelPrefix False "backlogQuota")


-- | 
data BacklogQuotaImpl = BacklogQuotaImpl
  { backlogQuotaImplLimit :: Maybe Integer -- ^ 
  , backlogQuotaImplLimitSize :: Maybe Integer -- ^ 
  , backlogQuotaImplLimitTime :: Maybe Int -- ^ 
  , backlogQuotaImplPolicy :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON BacklogQuotaImpl where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "backlogQuotaImpl")
instance ToJSON BacklogQuotaImpl where
  toJSON = genericToJSON (removeFieldLabelPrefix False "backlogQuotaImpl")


-- | 
data BitSet = BitSet
  { bitSetEmpty :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON BitSet where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "bitSet")
instance ToJSON BitSet where
  toJSON = genericToJSON (removeFieldLabelPrefix False "bitSet")


-- | 
data BookieAffinityGroupData = BookieAffinityGroupData
  { bookieAffinityGroupDataBookkeeperAffinityGroupPrimary :: Maybe Text -- ^ 
  , bookieAffinityGroupDataBookkeeperAffinityGroupSecondary :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON BookieAffinityGroupData where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "bookieAffinityGroupData")
instance ToJSON BookieAffinityGroupData where
  toJSON = genericToJSON (removeFieldLabelPrefix False "bookieAffinityGroupData")


-- | 
data BookieAffinityGroupDataImpl = BookieAffinityGroupDataImpl
  { bookieAffinityGroupDataImplBookkeeperAffinityGroupPrimary :: Maybe Text -- ^ 
  , bookieAffinityGroupDataImplBookkeeperAffinityGroupSecondary :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON BookieAffinityGroupDataImpl where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "bookieAffinityGroupDataImpl")
instance ToJSON BookieAffinityGroupDataImpl where
  toJSON = genericToJSON (removeFieldLabelPrefix False "bookieAffinityGroupDataImpl")


-- | 
data BookieInfo = BookieInfo
  { bookieInfoHostname :: Maybe Text -- ^ 
  , bookieInfoRack :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON BookieInfo where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "bookieInfo")
instance ToJSON BookieInfo where
  toJSON = genericToJSON (removeFieldLabelPrefix False "bookieInfo")


-- | 
data BookiesClusterInfo = BookiesClusterInfo
  { bookiesClusterInfoBookies :: Maybe [RawBookieInfo] -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON BookiesClusterInfo where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "bookiesClusterInfo")
instance ToJSON BookiesClusterInfo where
  toJSON = genericToJSON (removeFieldLabelPrefix False "bookiesClusterInfo")


-- | 
data BrokerInfo = BrokerInfo
  { brokerInfoBrokerId :: Maybe Text -- ^ 
  , brokerInfoServiceUrl :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON BrokerInfo where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "brokerInfo")
instance ToJSON BrokerInfo where
  toJSON = genericToJSON (removeFieldLabelPrefix False "brokerInfo")


-- | The namespace isolation data for a given broker
data BrokerNamespaceIsolationData = BrokerNamespaceIsolationData
  { brokerNamespaceIsolationDataBrokerName :: Maybe Text -- ^ The broker name
  , brokerNamespaceIsolationDataNamespaceRegex :: Maybe [Text] -- ^ The namespace-isolation policies attached to this broker
  , brokerNamespaceIsolationDataPolicyName :: Maybe Text -- ^ Policy name
  , brokerNamespaceIsolationDataPrimary :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON BrokerNamespaceIsolationData where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "brokerNamespaceIsolationData")
instance ToJSON BrokerNamespaceIsolationData where
  toJSON = genericToJSON (removeFieldLabelPrefix False "brokerNamespaceIsolationData")


-- | 
data BundlesData = BundlesData
  { bundlesDataBoundaries :: Maybe [Text] -- ^ 
  , bundlesDataNumBundles :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON BundlesData where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "bundlesData")
instance ToJSON BundlesData where
  toJSON = genericToJSON (removeFieldLabelPrefix False "bundlesData")


-- | 
data BundlesDataImpl = BundlesDataImpl
  { bundlesDataImplBoundaries :: Maybe [Text] -- ^ 
  , bundlesDataImplNumBundles :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON BundlesDataImpl where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "bundlesDataImpl")
instance ToJSON BundlesDataImpl where
  toJSON = genericToJSON (removeFieldLabelPrefix False "bundlesDataImpl")


-- | 
data Certificate = Certificate
  { certificateEncoded :: Maybe [Text] -- ^ 
  , certificatePublicKey :: Maybe PublicKey -- ^ 
  , certificateType :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON Certificate where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "certificate")
instance ToJSON Certificate where
  toJSON = genericToJSON (removeFieldLabelPrefix False "certificate")


-- | The configuration data for a cluster
data ClusterData = ClusterData
  { clusterDataAuthenticationParameters :: Maybe Text -- ^ Authentication parameters when client would like to connect to cluster.
  , clusterDataAuthenticationPlugin :: Maybe Text -- ^ Authentication plugin when client would like to connect to cluster.
  , clusterDataBrokerClientCertificateFilePath :: Maybe Text -- ^ TLS certificate file for internal client, used by the internal client to authenticate with Pulsar brokers
  , clusterDataBrokerClientKeyFilePath :: Maybe Text -- ^ TLS private key file for internal client, used by the internal client to authenticate with Pulsar brokers
  , clusterDataBrokerClientSslFactoryPlugin :: Maybe Text -- ^ SSL Factory plugin used by internal client to generate the SSL Context and Engine
  , clusterDataBrokerClientSslFactoryPluginParams :: Maybe Text -- ^ Parameters used by the internal client's SSL factory plugin to generate the SSL Context and Engine
  , clusterDataBrokerClientTlsEnabled :: Maybe Bool -- ^ Enable TLS when talking with other brokers in the same cluster (admin operation) or different clusters (replication)
  , clusterDataBrokerClientTlsEnabledWithKeyStore :: Maybe Bool -- ^ Whether internal client use KeyStore type to authenticate with other Pulsar brokers
  , clusterDataBrokerClientTlsKeyStore :: Maybe Text -- ^ TLS KeyStore path for internal client,  used by the internal client to authenticate with Pulsar brokers
  , clusterDataBrokerClientTlsKeyStorePassword :: Maybe Text -- ^ TLS KeyStore password for internal client,  used by the internal client to authenticate with Pulsar brokers
  , clusterDataBrokerClientTlsKeyStoreType :: Maybe Text -- ^ TLS KeyStore type configuration for internal client: JKS, PKCS12, used by the internal client to authenticate with Pulsar brokers
  , clusterDataBrokerClientTlsTrustStore :: Maybe Text -- ^ TLS TrustStore path for internal client used by the internal client to authenticate with Pulsar brokers
  , clusterDataBrokerClientTlsTrustStorePassword :: Maybe Text -- ^ TLS TrustStore password for internal client used by the internal client to authenticate with Pulsar brokers
  , clusterDataBrokerClientTlsTrustStoreType :: Maybe Text -- ^ TLS TrustStore type configuration for internal client: JKS, PKCS12 used by the internal client to authenticate with Pulsar brokers
  , clusterDataBrokerClientTrustCertsFilePath :: Maybe Text -- ^ Path for the trusted TLS certificate file for outgoing connection to a server (broker)
  , clusterDataBrokerServiceUrl :: Maybe Text -- ^ The broker service url (for produce and consume operations)
  , clusterDataBrokerServiceUrlTls :: Maybe Text -- ^ The secured broker service url (for produce and consume operations)
  , clusterDataListenerName :: Maybe Text -- ^ listenerName when client would like to connect to cluster
  , clusterDataPeerClusterNames :: Maybe [Text] -- ^ A set of peer cluster names
  , clusterDataProxyProtocol :: Maybe Text -- ^ protocol to decide type of proxy routing eg: SNI-routing
  , clusterDataProxyServiceUrl :: Maybe Text -- ^ Proxy-service url when client would like to connect to broker via proxy.
  , clusterDataServiceUrl :: Maybe Text -- ^ The HTTP rest service URL (for admin operations)
  , clusterDataServiceUrlTls :: Maybe Text -- ^ The HTTPS rest service URL (for admin operations)
  , clusterDataTlsAllowInsecureConnection :: Maybe Bool -- ^ Allow TLS connections to servers whose certificate cannot be verified to have been signed by a trusted certificate authority.
  } deriving (Show, Eq, Generic)

instance FromJSON ClusterData where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "clusterData")
instance ToJSON ClusterData where
  toJSON = genericToJSON (removeFieldLabelPrefix False "clusterData")


-- | 
data ClusterUrl = ClusterUrl
  { clusterUrlBrokerServiceUrl :: Maybe Text -- ^ 
  , clusterUrlBrokerServiceUrlTls :: Maybe Text -- ^ 
  , clusterUrlEmpty :: Maybe Bool -- ^ 
  , clusterUrlServiceUrl :: Maybe Text -- ^ 
  , clusterUrlServiceUrlTls :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON ClusterUrl where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "clusterUrl")
instance ToJSON ClusterUrl where
  toJSON = genericToJSON (removeFieldLabelPrefix False "clusterUrl")


-- | 
data CompactionStats = CompactionStats
  { compactionStatsLastCompactionDurationTimeInMills :: Maybe Integer -- ^ 
  , compactionStatsLastCompactionFailedTimestamp :: Maybe Integer -- ^ 
  , compactionStatsLastCompactionRemovedEventCount :: Maybe Integer -- ^ 
  , compactionStatsLastCompactionSucceedTimestamp :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CompactionStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "compactionStats")
instance ToJSON CompactionStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "compactionStats")


-- | 
data CompactionStatsImpl = CompactionStatsImpl
  { compactionStatsImplLastCompactionDurationTimeInMills :: Maybe Integer -- ^ 
  , compactionStatsImplLastCompactionFailedTimestamp :: Maybe Integer -- ^ 
  , compactionStatsImplLastCompactionRemovedEventCount :: Maybe Integer -- ^ 
  , compactionStatsImplLastCompactionSucceedTimestamp :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CompactionStatsImpl where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "compactionStatsImpl")
instance ToJSON CompactionStatsImpl where
  toJSON = genericToJSON (removeFieldLabelPrefix False "compactionStatsImpl")


-- | 
data CompletableFuture = CompletableFuture
  { completableFutureCancelled :: Maybe Bool -- ^ 
  , completableFutureCompletedExceptionally :: Maybe Bool -- ^ 
  , completableFutureDone :: Maybe Bool -- ^ 
  , completableFutureNumberOfDependents :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CompletableFuture where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "completableFuture")
instance ToJSON CompletableFuture where
  toJSON = genericToJSON (removeFieldLabelPrefix False "completableFuture")


-- | 
data CompletableFutureClusterData = CompletableFutureClusterData
  { completableFutureClusterDataCancelled :: Maybe Bool -- ^ 
  , completableFutureClusterDataCompletedExceptionally :: Maybe Bool -- ^ 
  , completableFutureClusterDataDone :: Maybe Bool -- ^ 
  , completableFutureClusterDataNumberOfDependents :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CompletableFutureClusterData where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "completableFutureClusterData")
instance ToJSON CompletableFutureClusterData where
  toJSON = genericToJSON (removeFieldLabelPrefix False "completableFutureClusterData")


-- | 
data CompletableFutureListSchemaAndMetadata = CompletableFutureListSchemaAndMetadata
  { completableFutureListSchemaAndMetadataCancelled :: Maybe Bool -- ^ 
  , completableFutureListSchemaAndMetadataCompletedExceptionally :: Maybe Bool -- ^ 
  , completableFutureListSchemaAndMetadataDone :: Maybe Bool -- ^ 
  , completableFutureListSchemaAndMetadataNumberOfDependents :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CompletableFutureListSchemaAndMetadata where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "completableFutureListSchemaAndMetadata")
instance ToJSON CompletableFutureListSchemaAndMetadata where
  toJSON = genericToJSON (removeFieldLabelPrefix False "completableFutureListSchemaAndMetadata")


-- | 
data CompletableFutureLong = CompletableFutureLong
  { completableFutureLongCancelled :: Maybe Bool -- ^ 
  , completableFutureLongCompletedExceptionally :: Maybe Bool -- ^ 
  , completableFutureLongDone :: Maybe Bool -- ^ 
  , completableFutureLongNumberOfDependents :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CompletableFutureLong where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "completableFutureLong")
instance ToJSON CompletableFutureLong where
  toJSON = genericToJSON (removeFieldLabelPrefix False "completableFutureLong")


-- | 
data CompletableFuturePairBooleanSchemaCompatibilityStrategy = CompletableFuturePairBooleanSchemaCompatibilityStrategy
  { completableFuturePairBooleanSchemaCompatibilityStrategyCancelled :: Maybe Bool -- ^ 
  , completableFuturePairBooleanSchemaCompatibilityStrategyCompletedExceptionally :: Maybe Bool -- ^ 
  , completableFuturePairBooleanSchemaCompatibilityStrategyDone :: Maybe Bool -- ^ 
  , completableFuturePairBooleanSchemaCompatibilityStrategyNumberOfDependents :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CompletableFuturePairBooleanSchemaCompatibilityStrategy where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "completableFuturePairBooleanSchemaCompatibilityStrategy")
instance ToJSON CompletableFuturePairBooleanSchemaCompatibilityStrategy where
  toJSON = genericToJSON (removeFieldLabelPrefix False "completableFuturePairBooleanSchemaCompatibilityStrategy")


-- | 
data CompletableFuturePartitionedTopicMetadata = CompletableFuturePartitionedTopicMetadata
  { completableFuturePartitionedTopicMetadataCancelled :: Maybe Bool -- ^ 
  , completableFuturePartitionedTopicMetadataCompletedExceptionally :: Maybe Bool -- ^ 
  , completableFuturePartitionedTopicMetadataDone :: Maybe Bool -- ^ 
  , completableFuturePartitionedTopicMetadataNumberOfDependents :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CompletableFuturePartitionedTopicMetadata where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "completableFuturePartitionedTopicMetadata")
instance ToJSON CompletableFuturePartitionedTopicMetadata where
  toJSON = genericToJSON (removeFieldLabelPrefix False "completableFuturePartitionedTopicMetadata")


-- | 
data CompletableFutureResourceQuota = CompletableFutureResourceQuota
  { completableFutureResourceQuotaCancelled :: Maybe Bool -- ^ 
  , completableFutureResourceQuotaCompletedExceptionally :: Maybe Bool -- ^ 
  , completableFutureResourceQuotaDone :: Maybe Bool -- ^ 
  , completableFutureResourceQuotaNumberOfDependents :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CompletableFutureResourceQuota where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "completableFutureResourceQuota")
instance ToJSON CompletableFutureResourceQuota where
  toJSON = genericToJSON (removeFieldLabelPrefix False "completableFutureResourceQuota")


-- | 
data CompletableFutureSchemaAndMetadata = CompletableFutureSchemaAndMetadata
  { completableFutureSchemaAndMetadataCancelled :: Maybe Bool -- ^ 
  , completableFutureSchemaAndMetadataCompletedExceptionally :: Maybe Bool -- ^ 
  , completableFutureSchemaAndMetadataDone :: Maybe Bool -- ^ 
  , completableFutureSchemaAndMetadataNumberOfDependents :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CompletableFutureSchemaAndMetadata where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "completableFutureSchemaAndMetadata")
instance ToJSON CompletableFutureSchemaAndMetadata where
  toJSON = genericToJSON (removeFieldLabelPrefix False "completableFutureSchemaAndMetadata")


-- | 
data CompletableFutureSchemaMetadata = CompletableFutureSchemaMetadata
  { completableFutureSchemaMetadataCancelled :: Maybe Bool -- ^ 
  , completableFutureSchemaMetadataCompletedExceptionally :: Maybe Bool -- ^ 
  , completableFutureSchemaMetadataDone :: Maybe Bool -- ^ 
  , completableFutureSchemaMetadataNumberOfDependents :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CompletableFutureSchemaMetadata where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "completableFutureSchemaMetadata")
instance ToJSON CompletableFutureSchemaMetadata where
  toJSON = genericToJSON (removeFieldLabelPrefix False "completableFutureSchemaMetadata")


-- | 
data CompletableFutureSchemaVersion = CompletableFutureSchemaVersion
  { completableFutureSchemaVersionCancelled :: Maybe Bool -- ^ 
  , completableFutureSchemaVersionCompletedExceptionally :: Maybe Bool -- ^ 
  , completableFutureSchemaVersionDone :: Maybe Bool -- ^ 
  , completableFutureSchemaVersionNumberOfDependents :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CompletableFutureSchemaVersion where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "completableFutureSchemaVersion")
instance ToJSON CompletableFutureSchemaVersion where
  toJSON = genericToJSON (removeFieldLabelPrefix False "completableFutureSchemaVersion")


-- | 
data CompletableFutureVoid = CompletableFutureVoid
  { completableFutureVoidCancelled :: Maybe Bool -- ^ 
  , completableFutureVoidCompletedExceptionally :: Maybe Bool -- ^ 
  , completableFutureVoidDone :: Maybe Bool -- ^ 
  , completableFutureVoidNumberOfDependents :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CompletableFutureVoid where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "completableFutureVoid")
instance ToJSON CompletableFutureVoid where
  toJSON = genericToJSON (removeFieldLabelPrefix False "completableFutureVoid")


-- | 
data ConnectorDefinition = ConnectorDefinition
  { connectorDefinitionDescription :: Maybe Text -- ^ 
  , connectorDefinitionName :: Maybe Text -- ^ 
  , connectorDefinitionSinkClass :: Maybe Text -- ^ 
  , connectorDefinitionSinkConfigClass :: Maybe Text -- ^ 
  , connectorDefinitionSourceClass :: Maybe Text -- ^ 
  , connectorDefinitionSourceConfigClass :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON ConnectorDefinition where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "connectorDefinition")
instance ToJSON ConnectorDefinition where
  toJSON = genericToJSON (removeFieldLabelPrefix False "connectorDefinition")


-- | 
data ConsumerStats = ConsumerStats
  { consumerStatsAddress :: Maybe Text -- ^ 
  , consumerStatsAppId :: Maybe Text -- ^ 
  , consumerStatsAvailablePermits :: Maybe Int -- ^ 
  , consumerStatsAvgMessagesPerEntry :: Maybe Int -- ^ 
  , consumerStatsBlockedConsumerOnUnackedMsgs :: Maybe Bool -- ^ 
  , consumerStatsBytesOutCounter :: Maybe Integer -- ^ 
  , consumerStatsChunkedMessageRate :: Maybe Double -- ^ 
  , consumerStatsClientVersion :: Maybe Text -- ^ 
  , consumerStatsConnectedSince :: Maybe Text -- ^ 
  , consumerStatsConsumerName :: Maybe Text -- ^ 
  , consumerStatsDrainingHashes :: Maybe [DrainingHash] -- ^ 
  , consumerStatsDrainingHashesClearedTotal :: Maybe Integer -- ^ 
  , consumerStatsDrainingHashesCount :: Maybe Int -- ^ 
  , consumerStatsDrainingHashesUnackedMessages :: Maybe Int -- ^ 
  , consumerStatsFirstConsumedFlowTimestamp :: Maybe Integer -- ^ 
  , consumerStatsFirstMessagesSentTimestamp :: Maybe Integer -- ^ 
  , consumerStatsKeyHashRangeArrays :: Maybe [[Int]] -- ^ 
  , consumerStatsKeyHashRanges :: Maybe [Text] -- ^ 
  , consumerStatsLastAckedTimestamp :: Maybe Integer -- ^ 
  , consumerStatsLastConsumedFlowTimestamp :: Maybe Integer -- ^ 
  , consumerStatsLastConsumedTimestamp :: Maybe Integer -- ^ 
  , consumerStatsMessageAckRate :: Maybe Double -- ^ 
  , consumerStatsMetadata :: Maybe (Map.Map String Text) -- ^ 
  , consumerStatsMsgOutCounter :: Maybe Integer -- ^ 
  , consumerStatsMsgRateOut :: Maybe Double -- ^ 
  , consumerStatsMsgRateRedeliver :: Maybe Double -- ^ 
  , consumerStatsMsgThroughputOut :: Maybe Double -- ^ 
  , consumerStatsReadPositionWhenJoining :: Maybe Text -- ^ 
  , consumerStatsUnackedMessages :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON ConsumerStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "consumerStats")
instance ToJSON ConsumerStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "consumerStats")


-- | 
data CursorDetails = CursorDetails
  { cursorDetailsCursorBacklog :: Maybe Integer -- ^ 
  , cursorDetailsCursorLedgerId :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CursorDetails where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "cursorDetails")
instance ToJSON CursorDetails where
  toJSON = genericToJSON (removeFieldLabelPrefix False "cursorDetails")


-- | 
data CursorInfo = CursorInfo
  { cursorInfoCreationDate :: Maybe Text -- ^ 
  , cursorInfoCursorsLedgerId :: Maybe Integer -- ^ 
  , cursorInfoIndividualDeletedMessages :: Maybe [MessageRangeInfo] -- ^ 
  , cursorInfoMarkDelete :: Maybe PositionInfo -- ^ 
  , cursorInfoModificationDate :: Maybe Text -- ^ 
  , cursorInfoProperties :: Maybe (Map.Map String Integer) -- ^ 
  , cursorInfoVersion :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CursorInfo where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "cursorInfo")
instance ToJSON CursorInfo where
  toJSON = genericToJSON (removeFieldLabelPrefix False "cursorInfo")


-- | 
data CursorStats = CursorStats
  { cursorStatsActive :: Maybe Bool -- ^ 
  , cursorStatsCursorLedger :: Maybe Integer -- ^ 
  , cursorStatsCursorLedgerLastEntry :: Maybe Integer -- ^ 
  , cursorStatsIndividuallyDeletedMessages :: Maybe Text -- ^ 
  , cursorStatsLastLedgerSwitchTimestamp :: Maybe Text -- ^ 
  , cursorStatsMarkDeletePosition :: Maybe Text -- ^ 
  , cursorStatsMessagesConsumedCounter :: Maybe Integer -- ^ 
  , cursorStatsNumberOfEntriesSinceFirstNotAckedMessage :: Maybe Integer -- ^ 
  , cursorStatsPendingReadOps :: Maybe Int -- ^ 
  , cursorStatsProperties :: Maybe (Map.Map String Integer) -- ^ 
  , cursorStatsReadPosition :: Maybe Text -- ^ 
  , cursorStatsState :: Maybe Text -- ^ 
  , cursorStatsSubscriptionHavePendingRead :: Maybe Bool -- ^ 
  , cursorStatsSubscriptionHavePendingReplayRead :: Maybe Bool -- ^ 
  , cursorStatsTotalNonContiguousDeletedMessagesRange :: Maybe Int -- ^ 
  , cursorStatsWaitingReadOp :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON CursorStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "cursorStats")
instance ToJSON CursorStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "cursorStats")


-- | 
data DelayedDeliveryPolicies = DelayedDeliveryPolicies
  { delayedDeliveryPoliciesActive :: Maybe Bool -- ^ 
  , delayedDeliveryPoliciesMaxDeliveryDelayInMillis :: Maybe Integer -- ^ 
  , delayedDeliveryPoliciesTickTime :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON DelayedDeliveryPolicies where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "delayedDeliveryPolicies")
instance ToJSON DelayedDeliveryPolicies where
  toJSON = genericToJSON (removeFieldLabelPrefix False "delayedDeliveryPolicies")


-- | 
data DeleteSchemaResponse = DeleteSchemaResponse
  { deleteSchemaResponseVersion :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON DeleteSchemaResponse where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "deleteSchemaResponse")
instance ToJSON DeleteSchemaResponse where
  toJSON = genericToJSON (removeFieldLabelPrefix False "deleteSchemaResponse")


-- | 
data DispatchRate = DispatchRate
  { dispatchRateDispatchThrottlingRateInByte :: Maybe Integer -- ^ 
  , dispatchRateDispatchThrottlingRateInMsg :: Maybe Int -- ^ 
  , dispatchRateRatePeriodInSecond :: Maybe Int -- ^ 
  , dispatchRateRelativeToPublishRate :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON DispatchRate where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "dispatchRate")
instance ToJSON DispatchRate where
  toJSON = genericToJSON (removeFieldLabelPrefix False "dispatchRate")


-- | 
data DispatchRateImpl = DispatchRateImpl
  { dispatchRateImplDispatchThrottlingRateInByte :: Maybe Integer -- ^ 
  , dispatchRateImplDispatchThrottlingRateInMsg :: Maybe Int -- ^ 
  , dispatchRateImplRatePeriodInSecond :: Maybe Int -- ^ 
  , dispatchRateImplRelativeToPublishRate :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON DispatchRateImpl where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "dispatchRateImpl")
instance ToJSON DispatchRateImpl where
  toJSON = genericToJSON (removeFieldLabelPrefix False "dispatchRateImpl")


-- | 
data DrainingHash = DrainingHash
  { drainingHashBlockedAttempts :: Maybe Int -- ^ 
  , drainingHashHash :: Maybe Int -- ^ 
  , drainingHashUnackMsgs :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON DrainingHash where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "drainingHash")
instance ToJSON DrainingHash where
  toJSON = genericToJSON (removeFieldLabelPrefix False "drainingHash")


-- | 
data EntryFilters = EntryFilters
  { entryFiltersEntryFilterNames :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON EntryFilters where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "entryFilters")
instance ToJSON EntryFilters where
  toJSON = genericToJSON (removeFieldLabelPrefix False "entryFilters")


-- | The data of a failure domain configuration in a cluster
data FailureDomain = FailureDomain
  { failureDomainBrokers :: Maybe [Text] -- ^ The collection of brokers in the same failure domain
  } deriving (Show, Eq, Generic)

instance FromJSON FailureDomain where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "failureDomain")
instance ToJSON FailureDomain where
  toJSON = genericToJSON (removeFieldLabelPrefix False "failureDomain")


-- | 
data FunctionInstanceStatsData = FunctionInstanceStatsData
  { functionInstanceStatsDataAvgProcessLatency :: Maybe Double -- ^ 
  , functionInstanceStatsDataLastInvocation :: Maybe Integer -- ^ 
  , functionInstanceStatsDataOneMin :: Maybe FunctionInstanceStatsDataBase -- ^ 
  , functionInstanceStatsDataProcessedSuccessfullyTotal :: Maybe Integer -- ^ 
  , functionInstanceStatsDataReceivedTotal :: Maybe Integer -- ^ 
  , functionInstanceStatsDataSystemExceptionsTotal :: Maybe Integer -- ^ 
  , functionInstanceStatsDataUserExceptionsTotal :: Maybe Integer -- ^ 
  , functionInstanceStatsDataUserMetrics :: Maybe (Map.Map String Double) -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON FunctionInstanceStatsData where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "functionInstanceStatsData")
instance ToJSON FunctionInstanceStatsData where
  toJSON = genericToJSON (removeFieldLabelPrefix False "functionInstanceStatsData")


-- | 
data FunctionInstanceStatsDataBase = FunctionInstanceStatsDataBase
  { functionInstanceStatsDataBaseAvgProcessLatency :: Maybe Double -- ^ 
  , functionInstanceStatsDataBaseProcessedSuccessfullyTotal :: Maybe Integer -- ^ 
  , functionInstanceStatsDataBaseReceivedTotal :: Maybe Integer -- ^ 
  , functionInstanceStatsDataBaseSystemExceptionsTotal :: Maybe Integer -- ^ 
  , functionInstanceStatsDataBaseUserExceptionsTotal :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON FunctionInstanceStatsDataBase where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "functionInstanceStatsDataBase")
instance ToJSON FunctionInstanceStatsDataBase where
  toJSON = genericToJSON (removeFieldLabelPrefix False "functionInstanceStatsDataBase")


-- | 
data Functions = Functions
  { functionsListOfConnectors :: Maybe [ConnectorDefinition] -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON Functions where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "functions")
instance ToJSON Functions where
  toJSON = genericToJSON (removeFieldLabelPrefix False "functions")


-- | 
data FunctionsV2 = FunctionsV2
  { functionsV2ListOfConnectors :: Maybe [ConnectorDefinition] -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON FunctionsV2 where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "functionsV2")
instance ToJSON FunctionsV2 where
  toJSON = genericToJSON (removeFieldLabelPrefix False "functionsV2")


-- | 
data FunctionsV2WorkerService = FunctionsV2WorkerService
  { functionsV2WorkerServiceListOfConnectors :: Maybe [ConnectorDefinition] -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON FunctionsV2WorkerService where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "functionsV2WorkerService")
instance ToJSON FunctionsV2WorkerService where
  toJSON = genericToJSON (removeFieldLabelPrefix False "functionsV2WorkerService")


-- | 
data FunctionsWorkerService = FunctionsWorkerService
  { functionsWorkerServiceListOfConnectors :: Maybe [ConnectorDefinition] -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON FunctionsWorkerService where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "functionsWorkerService")
instance ToJSON FunctionsWorkerService where
  toJSON = genericToJSON (removeFieldLabelPrefix False "functionsWorkerService")


-- | 
data GetAllVersionsSchemaResponse = GetAllVersionsSchemaResponse
  { getAllVersionsSchemaResponseGetSchemaResponses :: Maybe [GetSchemaResponse] -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON GetAllVersionsSchemaResponse where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "getAllVersionsSchemaResponse")
instance ToJSON GetAllVersionsSchemaResponse where
  toJSON = genericToJSON (removeFieldLabelPrefix False "getAllVersionsSchemaResponse")


-- | 
data GetSchemaResponse = GetSchemaResponse
  { getSchemaResponseData :: Maybe Text -- ^ 
  , getSchemaResponseProperties :: Maybe (Map.Map String Text) -- ^ 
  , getSchemaResponseTimestamp :: Maybe Integer -- ^ 
  , getSchemaResponseType :: Maybe Text -- ^ 
  , getSchemaResponseVersion :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON GetSchemaResponse where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "getSchemaResponse")
instance ToJSON GetSchemaResponse where
  toJSON = genericToJSON (removeFieldLabelPrefix False "getSchemaResponse")


-- | 
data InactiveTopicPolicies = InactiveTopicPolicies
  { inactiveTopicPoliciesDeleteWhileInactive :: Maybe Bool -- ^ 
  , inactiveTopicPoliciesInactiveTopicDeleteMode :: Maybe Text -- ^ 
  , inactiveTopicPoliciesMaxInactiveDurationSeconds :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON InactiveTopicPolicies where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "inactiveTopicPolicies")
instance ToJSON InactiveTopicPolicies where
  toJSON = genericToJSON (removeFieldLabelPrefix False "inactiveTopicPolicies")


-- | 
data InternalConfigurationData = InternalConfigurationData
  { internalConfigurationDataBookkeeperMetadataServiceUri :: Maybe Text -- ^ 
  , internalConfigurationDataConfigurationMetadataStoreUrl :: Maybe Text -- ^ 
  , internalConfigurationDataConfigurationStoreServers :: Maybe Text -- ^ 
  , internalConfigurationDataLedgersRootPath :: Maybe Text -- ^ 
  , internalConfigurationDataMetadataStoreUrl :: Maybe Text -- ^ 
  , internalConfigurationDataStateStorageServiceUrl :: Maybe Text -- ^ 
  , internalConfigurationDataZookeeperServers :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON InternalConfigurationData where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "internalConfigurationData")
instance ToJSON InternalConfigurationData where
  toJSON = genericToJSON (removeFieldLabelPrefix False "internalConfigurationData")


-- | 
data IsCompatibilityResponse = IsCompatibilityResponse
  { isCompatibilityResponseCompatibility :: Maybe Bool -- ^ 
  , isCompatibilityResponseSchemaCompatibilityStrategy :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON IsCompatibilityResponse where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "isCompatibilityResponse")
instance ToJSON IsCompatibilityResponse where
  toJSON = genericToJSON (removeFieldLabelPrefix False "isCompatibilityResponse")


-- | 
data KubernetesContainerFactory = KubernetesContainerFactory
  { kubernetesContainerFactoryChangeConfigMap :: Maybe Text -- ^ 
  , kubernetesContainerFactoryChangeConfigMapNamespace :: Maybe Text -- ^ 
  , kubernetesContainerFactoryConfigAdminCLI :: Maybe Text -- ^ 
  , kubernetesContainerFactoryCpuOverCommitRatio :: Maybe Double -- ^ 
  , kubernetesContainerFactoryCustomLabels :: Maybe (Map.Map String Text) -- ^ 
  , kubernetesContainerFactoryExpectedMetricsCollectionInterval :: Maybe Int -- ^ 
  , kubernetesContainerFactoryExtraFunctionDependenciesDir :: Maybe Text -- ^ 
  , kubernetesContainerFactoryFunctionDockerImages :: Maybe (Map.Map String Text) -- ^ 
  , kubernetesContainerFactoryFunctionInstanceClassPath :: Maybe Text -- ^ 
  , kubernetesContainerFactoryGracePeriodSeconds :: Maybe Int -- ^ 
  , kubernetesContainerFactoryGrpcPort :: Maybe Int -- ^ 
  , kubernetesContainerFactoryImagePullPolicy :: Maybe Text -- ^ 
  , kubernetesContainerFactoryInstallUserCodeDependencies :: Maybe Bool -- ^ 
  , kubernetesContainerFactoryJobName :: Maybe Text -- ^ 
  , kubernetesContainerFactoryJobNamespace :: Maybe Text -- ^ 
  , kubernetesContainerFactoryK8Uri :: Maybe Text -- ^ 
  , kubernetesContainerFactoryKubernetesFunctionAuthProviderConfig :: Maybe (Map.Map String Value) -- ^ 
  , kubernetesContainerFactoryMemoryOverCommitRatio :: Maybe Double -- ^ 
  , kubernetesContainerFactoryMetricsPort :: Maybe Int -- ^ 
  , kubernetesContainerFactoryNarExtractionDirectory :: Maybe Text -- ^ 
  , kubernetesContainerFactoryPercentMemoryPadding :: Maybe Int -- ^ 
  , kubernetesContainerFactoryPulsarAdminUrl :: Maybe Text -- ^ 
  , kubernetesContainerFactoryPulsarDockerImageName :: Maybe Text -- ^ 
  , kubernetesContainerFactoryPulsarRootDir :: Maybe Text -- ^ 
  , kubernetesContainerFactoryPulsarServiceUrl :: Maybe Text -- ^ 
  , kubernetesContainerFactoryPythonDependencyRepository :: Maybe Text -- ^ 
  , kubernetesContainerFactoryPythonExtraDependencyRepository :: Maybe Text -- ^ 
  , kubernetesContainerFactorySubmittingInsidePod :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON KubernetesContainerFactory where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "kubernetesContainerFactory")
instance ToJSON KubernetesContainerFactory where
  toJSON = genericToJSON (removeFieldLabelPrefix False "kubernetesContainerFactory")


-- | 
data LedgerDetails = LedgerDetails
  { ledgerDetailsEntries :: Maybe Integer -- ^ 
  , ledgerDetailsLedgerId :: Maybe Integer -- ^ 
  , ledgerDetailsSize :: Maybe Integer -- ^ 
  , ledgerDetailsTimestamp :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON LedgerDetails where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "ledgerDetails")
instance ToJSON LedgerDetails where
  toJSON = genericToJSON (removeFieldLabelPrefix False "ledgerDetails")


-- | 
data LedgerInfo = LedgerInfo
  { ledgerInfoEntries :: Maybe Integer -- ^ 
  , ledgerInfoLedgerId :: Maybe Integer -- ^ 
  , ledgerInfoMetadata :: Maybe Text -- ^ 
  , ledgerInfoOffloaded :: Maybe Bool -- ^ 
  , ledgerInfoProperties :: Maybe (Map.Map String Text) -- ^ 
  , ledgerInfoSize :: Maybe Integer -- ^ 
  , ledgerInfoUnderReplicated :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON LedgerInfo where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "ledgerInfo")
instance ToJSON LedgerInfo where
  toJSON = genericToJSON (removeFieldLabelPrefix False "ledgerInfo")


-- | 
data LoadReport = LoadReport
  { loadReportAllocatedBandwidthIn :: Maybe Double -- ^ 
  , loadReportAllocatedBandwidthOut :: Maybe Double -- ^ 
  , loadReportAllocatedCPU :: Maybe Double -- ^ 
  , loadReportAllocatedMemory :: Maybe Double -- ^ 
  , loadReportAllocatedMsgRateIn :: Maybe Double -- ^ 
  , loadReportAllocatedMsgRateOut :: Maybe Double -- ^ 
  , loadReportBandwidthIn :: Maybe ResourceUsage -- ^ 
  , loadReportBandwidthOut :: Maybe ResourceUsage -- ^ 
  , loadReportBrokerVersionString :: Maybe Text -- ^ 
  , loadReportBundleGains :: Maybe [Text] -- ^ 
  , loadReportBundleLosses :: Maybe [Text] -- ^ 
  , loadReportBundleStats :: Maybe (Map.Map String NamespaceBundleStats) -- ^ 
  , loadReportCpu :: Maybe ResourceUsage -- ^ 
  , loadReportDirectMemory :: Maybe ResourceUsage -- ^ 
  , loadReportLastUpdate :: Maybe Integer -- ^ 
  , loadReportLoadManagerClassName :: Maybe Text -- ^ 
  , loadReportLoadReportType :: Maybe Text -- ^ 
  , loadReportMemory :: Maybe ResourceUsage -- ^ 
  , loadReportMsgRateIn :: Maybe Double -- ^ 
  , loadReportMsgRateOut :: Maybe Double -- ^ 
  , loadReportMsgThroughputIn :: Maybe Double -- ^ 
  , loadReportMsgThroughputOut :: Maybe Double -- ^ 
  , loadReportName :: Maybe Text -- ^ 
  , loadReportNonPersistentTopicsEnabled :: Maybe Bool -- ^ 
  , loadReportNumBundles :: Maybe Int -- ^ 
  , loadReportNumConsumers :: Maybe Int -- ^ 
  , loadReportNumProducers :: Maybe Int -- ^ 
  , loadReportNumTopics :: Maybe Integer -- ^ 
  , loadReportOverLoaded :: Maybe Bool -- ^ 
  , loadReportPersistentTopicsEnabled :: Maybe Bool -- ^ 
  , loadReportPreAllocatedBandwidthIn :: Maybe Double -- ^ 
  , loadReportPreAllocatedBandwidthOut :: Maybe Double -- ^ 
  , loadReportPreAllocatedCPU :: Maybe Double -- ^ 
  , loadReportPreAllocatedMemory :: Maybe Double -- ^ 
  , loadReportPreAllocatedMsgRateIn :: Maybe Double -- ^ 
  , loadReportPreAllocatedMsgRateOut :: Maybe Double -- ^ 
  , loadReportProtocols :: Maybe (Map.Map String Text) -- ^ 
  , loadReportPulsarServiceUrl :: Maybe Text -- ^ 
  , loadReportPulsarServiceUrlTls :: Maybe Text -- ^ 
  , loadReportStartTimestamp :: Maybe Integer -- ^ 
  , loadReportSystemResourceUsage :: Maybe SystemResourceUsage -- ^ 
  , loadReportTimestamp :: Maybe Integer -- ^ 
  , loadReportUnderLoaded :: Maybe Bool -- ^ 
  , loadReportWebServiceUrl :: Maybe Text -- ^ 
  , loadReportWebServiceUrlTls :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON LoadReport where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "loadReport")
instance ToJSON LoadReport where
  toJSON = genericToJSON (removeFieldLabelPrefix False "loadReport")


-- | 
data LongRunningProcessStatus = LongRunningProcessStatus
  { longRunningProcessStatusLastError :: Maybe Text -- ^ 
  , longRunningProcessStatusStatus :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON LongRunningProcessStatus where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "longRunningProcessStatus")
instance ToJSON LongRunningProcessStatus where
  toJSON = genericToJSON (removeFieldLabelPrefix False "longRunningProcessStatus")


-- | 
data LongSchemaVersion = LongSchemaVersion
  { longSchemaVersionVersion :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON LongSchemaVersion where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "longSchemaVersion")
instance ToJSON LongSchemaVersion where
  toJSON = genericToJSON (removeFieldLabelPrefix False "longSchemaVersion")


-- | 
data ManagedLedgerInfo = ManagedLedgerInfo
  { managedLedgerInfoCreationDate :: Maybe Text -- ^ 
  , managedLedgerInfoCursors :: Maybe (Map.Map String CursorInfo) -- ^ 
  , managedLedgerInfoLedgers :: Maybe [LedgerInfo] -- ^ 
  , managedLedgerInfoModificationDate :: Maybe Text -- ^ 
  , managedLedgerInfoProperties :: Maybe (Map.Map String Text) -- ^ 
  , managedLedgerInfoTerminatedPosition :: Maybe PositionInfo -- ^ 
  , managedLedgerInfoVersion :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON ManagedLedgerInfo where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "managedLedgerInfo")
instance ToJSON ManagedLedgerInfo where
  toJSON = genericToJSON (removeFieldLabelPrefix False "managedLedgerInfo")


-- | 
data MemoryLimit = MemoryLimit
  { memoryLimitAbsoluteValue :: Maybe Integer -- ^ 
  , memoryLimitPercentOfMaxDirectMemory :: Maybe Double -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON MemoryLimit where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "memoryLimit")
instance ToJSON MemoryLimit where
  toJSON = genericToJSON (removeFieldLabelPrefix False "memoryLimit")


-- | 
data MessageIdAdv = MessageIdAdv
  { messageIdAdvAckSet :: Maybe BitSet -- ^ 
  , messageIdAdvBatchIndex :: Maybe Int -- ^ 
  , messageIdAdvBatchSize :: Maybe Int -- ^ 
  , messageIdAdvEntryId :: Maybe Integer -- ^ 
  , messageIdAdvFirstChunkMessageId :: Maybe MessageIdAdv -- ^ 
  , messageIdAdvLedgerId :: Maybe Integer -- ^ 
  , messageIdAdvPartitionIndex :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON MessageIdAdv where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "messageIdAdv")
instance ToJSON MessageIdAdv where
  toJSON = genericToJSON (removeFieldLabelPrefix False "messageIdAdv")


-- | 
data MessageRangeInfo = MessageRangeInfo
  { messageRangeInfoFrom :: Maybe PositionInfo -- ^ 
  , messageRangeInfoTo :: Maybe PositionInfo -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON MessageRangeInfo where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "messageRangeInfo")
instance ToJSON MessageRangeInfo where
  toJSON = genericToJSON (removeFieldLabelPrefix False "messageRangeInfo")


-- | 
data Metrics = Metrics
  { metricsDimensions :: Maybe (Map.Map String Text) -- ^ 
  , metricsMetrics :: Maybe (Map.Map String Value) -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON Metrics where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "metrics")
instance ToJSON Metrics where
  toJSON = genericToJSON (removeFieldLabelPrefix False "metrics")


-- | 
data NamespaceBundleStats = NamespaceBundleStats
  { namespaceBundleStatsCacheSize :: Maybe Integer -- ^ 
  , namespaceBundleStatsConsumerCount :: Maybe Int -- ^ 
  , namespaceBundleStatsMsgRateIn :: Maybe Double -- ^ 
  , namespaceBundleStatsMsgRateOut :: Maybe Double -- ^ 
  , namespaceBundleStatsMsgThroughputIn :: Maybe Double -- ^ 
  , namespaceBundleStatsMsgThroughputOut :: Maybe Double -- ^ 
  , namespaceBundleStatsProducerCount :: Maybe Int -- ^ 
  , namespaceBundleStatsTopics :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON NamespaceBundleStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "namespaceBundleStats")
instance ToJSON NamespaceBundleStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "namespaceBundleStats")


-- | The data of namespace isolation configuration
data NamespaceIsolationData = NamespaceIsolationData
  { namespaceIsolationDataAutoUnderscorefailoverUnderscorepolicy :: Maybe AutoFailoverPolicyData -- ^ 
  , namespaceIsolationDataNamespaces :: Maybe [Text] -- ^ The list of namespaces to apply this namespace isolation data
  , namespaceIsolationDataPrimary :: Maybe [Text] -- ^ The list of primary brokers for serving the list of namespaces in this isolation policy
  , namespaceIsolationDataSecondary :: Maybe [Text] -- ^ The list of secondary brokers for serving the list of namespaces in this isolation policy
  , namespaceIsolationDataUnloadUnderscorescope :: Maybe Text -- ^ The type of unload to perform while applying the new isolation policy.
  } deriving (Show, Eq, Generic)

instance FromJSON NamespaceIsolationData where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "namespaceIsolationData")
instance ToJSON NamespaceIsolationData where
  toJSON = genericToJSON (removeFieldLabelPrefix False "namespaceIsolationData")


-- | 
data NamespaceOwnershipStatus = NamespaceOwnershipStatus
  { namespaceOwnershipStatusBrokerUnderscoreassignment :: Maybe Text -- ^ 
  , namespaceOwnershipStatusIsUnderscoreactive :: Maybe Bool -- ^ 
  , namespaceOwnershipStatusIsUnderscorecontrolled :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON NamespaceOwnershipStatus where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "namespaceOwnershipStatus")
instance ToJSON NamespaceOwnershipStatus where
  toJSON = genericToJSON (removeFieldLabelPrefix False "namespaceOwnershipStatus")


-- | 
data NonPersistentPartitionedTopicStatsImpl = NonPersistentPartitionedTopicStatsImpl
  { nonPersistentPartitionedTopicStatsImplAbortedTxnCount :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplAverageMsgSize :: Maybe Double -- ^ 
  , nonPersistentPartitionedTopicStatsImplBacklogQuotaLimitSize :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplBacklogQuotaLimitTime :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplBacklogSize :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplBytesInCounter :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplBytesOutCounter :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplBytesOutInternalCounter :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplCommittedTxnCount :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplCompaction :: Maybe CompactionStatsImpl -- ^ 
  , nonPersistentPartitionedTopicStatsImplDeduplicationStatus :: Maybe Text -- ^ 
  , nonPersistentPartitionedTopicStatsImplDelayedMessageIndexSizeInBytes :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplEarliestMsgPublishTimeInBacklogs :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplLastOffloadFailureTimeStamp :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplLastOffloadLedgerId :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplLastOffloadSuccessTimeStamp :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplLastPublishTimeStamp :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplMetadata :: Maybe PartitionedTopicMetadata -- ^ 
  , nonPersistentPartitionedTopicStatsImplMsgChunkPublished :: Maybe Bool -- ^ 
  , nonPersistentPartitionedTopicStatsImplMsgDropRate :: Maybe Double -- ^ 
  , nonPersistentPartitionedTopicStatsImplMsgInCounter :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplMsgOutCounter :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplMsgRateIn :: Maybe Double -- ^ 
  , nonPersistentPartitionedTopicStatsImplMsgRateOut :: Maybe Double -- ^ 
  , nonPersistentPartitionedTopicStatsImplMsgThroughputIn :: Maybe Double -- ^ 
  , nonPersistentPartitionedTopicStatsImplMsgThroughputOut :: Maybe Double -- ^ 
  , nonPersistentPartitionedTopicStatsImplNonContiguousDeletedMessagesRanges :: Maybe Int -- ^ 
  , nonPersistentPartitionedTopicStatsImplNonContiguousDeletedMessagesRangesSerializedSize :: Maybe Int -- ^ 
  , nonPersistentPartitionedTopicStatsImplOffloadedStorageSize :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplOldestBacklogMessageAgeSeconds :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplOldestBacklogMessageSubscriptionName :: Maybe Text -- ^ 
  , nonPersistentPartitionedTopicStatsImplOngoingTxnCount :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplOwnerBroker :: Maybe Text -- ^ 
  , nonPersistentPartitionedTopicStatsImplPartitions :: Maybe (Map.Map String NonPersistentTopicStatsImpl) -- ^ 
  , nonPersistentPartitionedTopicStatsImplPublishRateLimitedTimes :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplPublishers :: Maybe [NonPersistentPublisherStats] -- ^ 
  , nonPersistentPartitionedTopicStatsImplReplication :: Maybe (Map.Map String NonPersistentReplicatorStats) -- ^ 
  , nonPersistentPartitionedTopicStatsImplStorageSize :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplSubscriptions :: Maybe (Map.Map String NonPersistentSubscriptionStats) -- ^ 
  , nonPersistentPartitionedTopicStatsImplSystemTopicBytesInCounter :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplTopicCreationTimeStamp :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplTopicEpoch :: Maybe Integer -- ^ 
  , nonPersistentPartitionedTopicStatsImplWaitingPublishers :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON NonPersistentPartitionedTopicStatsImpl where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "nonPersistentPartitionedTopicStatsImpl")
instance ToJSON NonPersistentPartitionedTopicStatsImpl where
  toJSON = genericToJSON (removeFieldLabelPrefix False "nonPersistentPartitionedTopicStatsImpl")


-- | 
data NonPersistentPublisherStats = NonPersistentPublisherStats
  { nonPersistentPublisherStatsAccessMode :: Maybe Text -- ^ 
  , nonPersistentPublisherStatsAddress :: Maybe Text -- ^ 
  , nonPersistentPublisherStatsAverageMsgSize :: Maybe Double -- ^ 
  , nonPersistentPublisherStatsChunkedMessageRate :: Maybe Double -- ^ 
  , nonPersistentPublisherStatsClientVersion :: Maybe Text -- ^ 
  , nonPersistentPublisherStatsConnectedSince :: Maybe Text -- ^ 
  , nonPersistentPublisherStatsMetadata :: Maybe (Map.Map String Text) -- ^ 
  , nonPersistentPublisherStatsMsgDropRate :: Maybe Double -- ^ 
  , nonPersistentPublisherStatsMsgRateIn :: Maybe Double -- ^ 
  , nonPersistentPublisherStatsMsgThroughputIn :: Maybe Double -- ^ 
  , nonPersistentPublisherStatsProducerId :: Maybe Integer -- ^ 
  , nonPersistentPublisherStatsProducerName :: Maybe Text -- ^ 
  , nonPersistentPublisherStatsSupportsPartialProducer :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON NonPersistentPublisherStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "nonPersistentPublisherStats")
instance ToJSON NonPersistentPublisherStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "nonPersistentPublisherStats")


-- | 
data NonPersistentReplicatorStats = NonPersistentReplicatorStats
  { nonPersistentReplicatorStatsBytesInCount :: Maybe Integer -- ^ 
  , nonPersistentReplicatorStatsBytesOutCount :: Maybe Integer -- ^ 
  , nonPersistentReplicatorStatsConnected :: Maybe Bool -- ^ 
  , nonPersistentReplicatorStatsInboundConnectedSince :: Maybe Text -- ^ 
  , nonPersistentReplicatorStatsInboundConnection :: Maybe Text -- ^ 
  , nonPersistentReplicatorStatsMsgDropCount :: Maybe Integer -- ^ 
  , nonPersistentReplicatorStatsMsgDropRate :: Maybe Double -- ^ 
  , nonPersistentReplicatorStatsMsgExpiredCount :: Maybe Integer -- ^ 
  , nonPersistentReplicatorStatsMsgInCount :: Maybe Integer -- ^ 
  , nonPersistentReplicatorStatsMsgOutCount :: Maybe Integer -- ^ 
  , nonPersistentReplicatorStatsMsgRateExpired :: Maybe Double -- ^ 
  , nonPersistentReplicatorStatsMsgRateIn :: Maybe Double -- ^ 
  , nonPersistentReplicatorStatsMsgRateOut :: Maybe Double -- ^ 
  , nonPersistentReplicatorStatsMsgThroughputIn :: Maybe Double -- ^ 
  , nonPersistentReplicatorStatsMsgThroughputOut :: Maybe Double -- ^ 
  , nonPersistentReplicatorStatsOutboundConnectedSince :: Maybe Text -- ^ 
  , nonPersistentReplicatorStatsOutboundConnection :: Maybe Text -- ^ 
  , nonPersistentReplicatorStatsReplicationBacklog :: Maybe Integer -- ^ 
  , nonPersistentReplicatorStatsReplicationDelayInSeconds :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON NonPersistentReplicatorStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "nonPersistentReplicatorStats")
instance ToJSON NonPersistentReplicatorStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "nonPersistentReplicatorStats")


-- | 
data NonPersistentSubscriptionStats = NonPersistentSubscriptionStats
  { nonPersistentSubscriptionStatsActiveConsumerName :: Maybe Text -- ^ 
  , nonPersistentSubscriptionStatsAllowOutOfOrderDelivery :: Maybe Bool -- ^ 
  , nonPersistentSubscriptionStatsBacklogSize :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsBlockedSubscriptionOnUnackedMsgs :: Maybe Bool -- ^ 
  , nonPersistentSubscriptionStatsBytesOutCounter :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsChunkedMessageRate :: Maybe Double -- ^ 
  , nonPersistentSubscriptionStatsConsumers :: Maybe [ConsumerStats] -- ^ 
  , nonPersistentSubscriptionStatsConsumersAfterMarkDeletePosition :: Maybe (Map.Map String Text) -- ^ 
  , nonPersistentSubscriptionStatsDelayedMessageIndexSizeInBytes :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsDispatchThrottledBytesEventsByBrokerLimit :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsDispatchThrottledBytesEventsBySubscriptionLimit :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsDispatchThrottledBytesEventsByTopicLimit :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsDispatchThrottledMsgEventsByBrokerLimit :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsDispatchThrottledMsgEventsBySubscriptionLimit :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsDispatchThrottledMsgEventsByTopicLimit :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsDrainingHashesClearedTotal :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsDrainingHashesCount :: Maybe Int -- ^ 
  , nonPersistentSubscriptionStatsDrainingHashesUnackedMessages :: Maybe Int -- ^ 
  , nonPersistentSubscriptionStatsDurable :: Maybe Bool -- ^ 
  , nonPersistentSubscriptionStatsEarliestMsgPublishTimeInBacklog :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsFilterAcceptedMsgCount :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsFilterProcessedMsgCount :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsFilterRejectedMsgCount :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsFilterRescheduledMsgCount :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsKeySharedMode :: Maybe Text -- ^ 
  , nonPersistentSubscriptionStatsLastAckedTimestamp :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsLastConsumedFlowTimestamp :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsLastConsumedTimestamp :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsLastExpireTimestamp :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsLastMarkDeleteAdvancedTimestamp :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsMessageAckRate :: Maybe Double -- ^ 
  , nonPersistentSubscriptionStatsMsgBacklog :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsMsgBacklogNoDelayed :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsMsgDelayed :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsMsgDropRate :: Maybe Double -- ^ 
  , nonPersistentSubscriptionStatsMsgInReplay :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsMsgOutCounter :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsMsgRateExpired :: Maybe Double -- ^ 
  , nonPersistentSubscriptionStatsMsgRateOut :: Maybe Double -- ^ 
  , nonPersistentSubscriptionStatsMsgRateRedeliver :: Maybe Double -- ^ 
  , nonPersistentSubscriptionStatsMsgThroughputOut :: Maybe Double -- ^ 
  , nonPersistentSubscriptionStatsNonContiguousDeletedMessagesRanges :: Maybe Int -- ^ 
  , nonPersistentSubscriptionStatsNonContiguousDeletedMessagesRangesSerializedSize :: Maybe Int -- ^ 
  , nonPersistentSubscriptionStatsReplicated :: Maybe Bool -- ^ 
  , nonPersistentSubscriptionStatsSubscriptionProperties :: Maybe (Map.Map String Text) -- ^ 
  , nonPersistentSubscriptionStatsTotalMsgExpired :: Maybe Integer -- ^ 
  , nonPersistentSubscriptionStatsType :: Maybe Text -- ^ 
  , nonPersistentSubscriptionStatsUnackedMessages :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON NonPersistentSubscriptionStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "nonPersistentSubscriptionStats")
instance ToJSON NonPersistentSubscriptionStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "nonPersistentSubscriptionStats")


-- | 
data NonPersistentTopicStatsImpl = NonPersistentTopicStatsImpl
  { nonPersistentTopicStatsImplAbortedTxnCount :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplAverageMsgSize :: Maybe Double -- ^ 
  , nonPersistentTopicStatsImplBacklogQuotaLimitSize :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplBacklogQuotaLimitTime :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplBacklogSize :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplBytesInCounter :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplBytesOutCounter :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplBytesOutInternalCounter :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplCommittedTxnCount :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplCompaction :: Maybe CompactionStatsImpl -- ^ 
  , nonPersistentTopicStatsImplDeduplicationStatus :: Maybe Text -- ^ 
  , nonPersistentTopicStatsImplDelayedMessageIndexSizeInBytes :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplEarliestMsgPublishTimeInBacklogs :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplLastOffloadFailureTimeStamp :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplLastOffloadLedgerId :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplLastOffloadSuccessTimeStamp :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplLastPublishTimeStamp :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplMsgChunkPublished :: Maybe Bool -- ^ 
  , nonPersistentTopicStatsImplMsgDropRate :: Maybe Double -- ^ 
  , nonPersistentTopicStatsImplMsgInCounter :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplMsgOutCounter :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplMsgRateIn :: Maybe Double -- ^ 
  , nonPersistentTopicStatsImplMsgRateOut :: Maybe Double -- ^ 
  , nonPersistentTopicStatsImplMsgThroughputIn :: Maybe Double -- ^ 
  , nonPersistentTopicStatsImplMsgThroughputOut :: Maybe Double -- ^ 
  , nonPersistentTopicStatsImplNonContiguousDeletedMessagesRanges :: Maybe Int -- ^ 
  , nonPersistentTopicStatsImplNonContiguousDeletedMessagesRangesSerializedSize :: Maybe Int -- ^ 
  , nonPersistentTopicStatsImplOffloadedStorageSize :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplOldestBacklogMessageAgeSeconds :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplOldestBacklogMessageSubscriptionName :: Maybe Text -- ^ 
  , nonPersistentTopicStatsImplOngoingTxnCount :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplOwnerBroker :: Maybe Text -- ^ 
  , nonPersistentTopicStatsImplPublishRateLimitedTimes :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplPublishers :: Maybe [NonPersistentPublisherStats] -- ^ 
  , nonPersistentTopicStatsImplReplication :: Maybe (Map.Map String NonPersistentReplicatorStats) -- ^ 
  , nonPersistentTopicStatsImplStorageSize :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplSubscriptions :: Maybe (Map.Map String NonPersistentSubscriptionStats) -- ^ 
  , nonPersistentTopicStatsImplSystemTopicBytesInCounter :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplTopicCreationTimeStamp :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplTopicEpoch :: Maybe Integer -- ^ 
  , nonPersistentTopicStatsImplWaitingPublishers :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON NonPersistentTopicStatsImpl where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "nonPersistentTopicStatsImpl")
instance ToJSON NonPersistentTopicStatsImpl where
  toJSON = genericToJSON (removeFieldLabelPrefix False "nonPersistentTopicStatsImpl")


-- | 
data OffloadPolicies = OffloadPolicies
  { offloadPoliciesFileSystemProfilePath :: Maybe Text -- ^ 
  , offloadPoliciesFileSystemURI :: Maybe Text -- ^ 
  , offloadPoliciesGcsManagedLedgerOffloadBucket :: Maybe Text -- ^ 
  , offloadPoliciesGcsManagedLedgerOffloadMaxBlockSizeInBytes :: Maybe Int -- ^ 
  , offloadPoliciesGcsManagedLedgerOffloadReadBufferSizeInBytes :: Maybe Int -- ^ 
  , offloadPoliciesGcsManagedLedgerOffloadRegion :: Maybe Text -- ^ 
  , offloadPoliciesGcsManagedLedgerOffloadServiceAccountKeyFile :: Maybe Text -- ^ 
  , offloadPoliciesManagedLedgerOffloadBucket :: Maybe Text -- ^ 
  , offloadPoliciesManagedLedgerOffloadDeletionLagInMillis :: Maybe Integer -- ^ 
  , offloadPoliciesManagedLedgerOffloadDriver :: Maybe Text -- ^ 
  , offloadPoliciesManagedLedgerOffloadMaxBlockSizeInBytes :: Maybe Int -- ^ 
  , offloadPoliciesManagedLedgerOffloadMaxThreads :: Maybe Int -- ^ 
  , offloadPoliciesManagedLedgerOffloadPrefetchRounds :: Maybe Int -- ^ 
  , offloadPoliciesManagedLedgerOffloadReadBufferSizeInBytes :: Maybe Int -- ^ 
  , offloadPoliciesManagedLedgerOffloadRegion :: Maybe Text -- ^ 
  , offloadPoliciesManagedLedgerOffloadServiceEndpoint :: Maybe Text -- ^ 
  , offloadPoliciesManagedLedgerOffloadThresholdInBytes :: Maybe Integer -- ^ 
  , offloadPoliciesManagedLedgerOffloadThresholdInSeconds :: Maybe Integer -- ^ 
  , offloadPoliciesManagedLedgerOffloadedReadPriority :: Maybe Text -- ^ 
  , offloadPoliciesOffloadersDirectory :: Maybe Text -- ^ 
  , offloadPoliciesS3ManagedLedgerOffloadBucket :: Maybe Text -- ^ 
  , offloadPoliciesS3ManagedLedgerOffloadCredentialId :: Maybe Text -- ^ 
  , offloadPoliciesS3ManagedLedgerOffloadCredentialSecret :: Maybe Text -- ^ 
  , offloadPoliciesS3ManagedLedgerOffloadMaxBlockSizeInBytes :: Maybe Int -- ^ 
  , offloadPoliciesS3ManagedLedgerOffloadReadBufferSizeInBytes :: Maybe Int -- ^ 
  , offloadPoliciesS3ManagedLedgerOffloadRegion :: Maybe Text -- ^ 
  , offloadPoliciesS3ManagedLedgerOffloadRole :: Maybe Text -- ^ 
  , offloadPoliciesS3ManagedLedgerOffloadRoleSessionName :: Maybe Text -- ^ 
  , offloadPoliciesS3ManagedLedgerOffloadServiceEndpoint :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON OffloadPolicies where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "offloadPolicies")
instance ToJSON OffloadPolicies where
  toJSON = genericToJSON (removeFieldLabelPrefix False "offloadPolicies")


-- | 
data OffloadPoliciesImpl = OffloadPoliciesImpl
  { offloadPoliciesImplFileSystemDriver :: Maybe Bool -- ^ 
  , offloadPoliciesImplFileSystemProfilePath :: Maybe Text -- ^ 
  , offloadPoliciesImplFileSystemURI :: Maybe Text -- ^ 
  , offloadPoliciesImplGcsDriver :: Maybe Bool -- ^ 
  , offloadPoliciesImplGcsManagedLedgerOffloadBucket :: Maybe Text -- ^ 
  , offloadPoliciesImplGcsManagedLedgerOffloadMaxBlockSizeInBytes :: Maybe Int -- ^ 
  , offloadPoliciesImplGcsManagedLedgerOffloadReadBufferSizeInBytes :: Maybe Int -- ^ 
  , offloadPoliciesImplGcsManagedLedgerOffloadRegion :: Maybe Text -- ^ 
  , offloadPoliciesImplGcsManagedLedgerOffloadServiceAccountKeyFile :: Maybe Text -- ^ 
  , offloadPoliciesImplManagedLedgerExtraConfigurations :: Maybe (Map.Map String Text) -- ^ 
  , offloadPoliciesImplManagedLedgerOffloadBucket :: Maybe Text -- ^ 
  , offloadPoliciesImplManagedLedgerOffloadDeletionLagInMillis :: Maybe Integer -- ^ 
  , offloadPoliciesImplManagedLedgerOffloadDriver :: Maybe Text -- ^ 
  , offloadPoliciesImplManagedLedgerOffloadMaxBlockSizeInBytes :: Maybe Int -- ^ 
  , offloadPoliciesImplManagedLedgerOffloadMaxThreads :: Maybe Int -- ^ 
  , offloadPoliciesImplManagedLedgerOffloadPrefetchRounds :: Maybe Int -- ^ 
  , offloadPoliciesImplManagedLedgerOffloadReadBufferSizeInBytes :: Maybe Int -- ^ 
  , offloadPoliciesImplManagedLedgerOffloadReadThreads :: Maybe Int -- ^ 
  , offloadPoliciesImplManagedLedgerOffloadRegion :: Maybe Text -- ^ 
  , offloadPoliciesImplManagedLedgerOffloadServiceEndpoint :: Maybe Text -- ^ 
  , offloadPoliciesImplManagedLedgerOffloadThresholdInBytes :: Maybe Integer -- ^ 
  , offloadPoliciesImplManagedLedgerOffloadThresholdInSeconds :: Maybe Integer -- ^ 
  , offloadPoliciesImplManagedLedgerOffloadedReadPriority :: Maybe Text -- ^ 
  , offloadPoliciesImplOffloadersDirectory :: Maybe Text -- ^ 
  , offloadPoliciesImplS3Driver :: Maybe Bool -- ^ 
  , offloadPoliciesImplS3ManagedLedgerOffloadBucket :: Maybe Text -- ^ 
  , offloadPoliciesImplS3ManagedLedgerOffloadCredentialId :: Maybe Text -- ^ 
  , offloadPoliciesImplS3ManagedLedgerOffloadCredentialSecret :: Maybe Text -- ^ 
  , offloadPoliciesImplS3ManagedLedgerOffloadMaxBlockSizeInBytes :: Maybe Int -- ^ 
  , offloadPoliciesImplS3ManagedLedgerOffloadReadBufferSizeInBytes :: Maybe Int -- ^ 
  , offloadPoliciesImplS3ManagedLedgerOffloadRegion :: Maybe Text -- ^ 
  , offloadPoliciesImplS3ManagedLedgerOffloadRole :: Maybe Text -- ^ 
  , offloadPoliciesImplS3ManagedLedgerOffloadRoleSessionName :: Maybe Text -- ^ 
  , offloadPoliciesImplS3ManagedLedgerOffloadServiceEndpoint :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON OffloadPoliciesImpl where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "offloadPoliciesImpl")
instance ToJSON OffloadPoliciesImpl where
  toJSON = genericToJSON (removeFieldLabelPrefix False "offloadPoliciesImpl")


-- | 
data OffloadProcessStatus = OffloadProcessStatus
  { offloadProcessStatusFirstUnoffloadedMessage :: Maybe Value -- ^ 
  , offloadProcessStatusLastError :: Maybe Text -- ^ 
  , offloadProcessStatusStatus :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON OffloadProcessStatus where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "offloadProcessStatus")
instance ToJSON OffloadProcessStatus where
  toJSON = genericToJSON (removeFieldLabelPrefix False "offloadProcessStatus")


-- | 
data PartitionedManagedLedgerInfo = PartitionedManagedLedgerInfo
  { partitionedManagedLedgerInfoCreationDate :: Maybe Text -- ^ 
  , partitionedManagedLedgerInfoCursors :: Maybe (Map.Map String CursorInfo) -- ^ 
  , partitionedManagedLedgerInfoLedgers :: Maybe [LedgerInfo] -- ^ 
  , partitionedManagedLedgerInfoModificationDate :: Maybe Text -- ^ 
  , partitionedManagedLedgerInfoPartitions :: Maybe (Map.Map String ManagedLedgerInfo) -- ^ 
  , partitionedManagedLedgerInfoProperties :: Maybe (Map.Map String Text) -- ^ 
  , partitionedManagedLedgerInfoTerminatedPosition :: Maybe PositionInfo -- ^ 
  , partitionedManagedLedgerInfoVersion :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PartitionedManagedLedgerInfo where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "partitionedManagedLedgerInfo")
instance ToJSON PartitionedManagedLedgerInfo where
  toJSON = genericToJSON (removeFieldLabelPrefix False "partitionedManagedLedgerInfo")


-- | 
data PartitionedTopicInternalStats = PartitionedTopicInternalStats
  { partitionedTopicInternalStatsMetadata :: Maybe PartitionedTopicMetadata -- ^ 
  , partitionedTopicInternalStatsPartitions :: Maybe (Map.Map String PersistentTopicInternalStats) -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PartitionedTopicInternalStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "partitionedTopicInternalStats")
instance ToJSON PartitionedTopicInternalStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "partitionedTopicInternalStats")


-- | 
data PartitionedTopicMetadata = PartitionedTopicMetadata
  { partitionedTopicMetadataDeleted :: Maybe Bool -- ^ 
  , partitionedTopicMetadataPartitions :: Maybe Int -- ^ 
  , partitionedTopicMetadataProperties :: Maybe (Map.Map String Text) -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PartitionedTopicMetadata where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "partitionedTopicMetadata")
instance ToJSON PartitionedTopicMetadata where
  toJSON = genericToJSON (removeFieldLabelPrefix False "partitionedTopicMetadata")


-- | 
data PartitionedTopicStatsImpl = PartitionedTopicStatsImpl
  { partitionedTopicStatsImplAbortedTxnCount :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplAverageMsgSize :: Maybe Double -- ^ 
  , partitionedTopicStatsImplBacklogQuotaLimitSize :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplBacklogQuotaLimitTime :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplBacklogSize :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplBytesInCounter :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplBytesOutCounter :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplBytesOutInternalCounter :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplCommittedTxnCount :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplCompaction :: Maybe CompactionStatsImpl -- ^ 
  , partitionedTopicStatsImplDeduplicationStatus :: Maybe Text -- ^ 
  , partitionedTopicStatsImplDelayedMessageIndexSizeInBytes :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplEarliestMsgPublishTimeInBacklogs :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplLastOffloadFailureTimeStamp :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplLastOffloadLedgerId :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplLastOffloadSuccessTimeStamp :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplLastPublishTimeStamp :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplMetadata :: Maybe PartitionedTopicMetadata -- ^ 
  , partitionedTopicStatsImplMsgChunkPublished :: Maybe Bool -- ^ 
  , partitionedTopicStatsImplMsgInCounter :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplMsgOutCounter :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplMsgRateIn :: Maybe Double -- ^ 
  , partitionedTopicStatsImplMsgRateOut :: Maybe Double -- ^ 
  , partitionedTopicStatsImplMsgThroughputIn :: Maybe Double -- ^ 
  , partitionedTopicStatsImplMsgThroughputOut :: Maybe Double -- ^ 
  , partitionedTopicStatsImplNonContiguousDeletedMessagesRanges :: Maybe Int -- ^ 
  , partitionedTopicStatsImplNonContiguousDeletedMessagesRangesSerializedSize :: Maybe Int -- ^ 
  , partitionedTopicStatsImplOffloadedStorageSize :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplOldestBacklogMessageAgeSeconds :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplOldestBacklogMessageSubscriptionName :: Maybe Text -- ^ 
  , partitionedTopicStatsImplOngoingTxnCount :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplOwnerBroker :: Maybe Text -- ^ 
  , partitionedTopicStatsImplPartitions :: Maybe (Map.Map String TopicStats) -- ^ 
  , partitionedTopicStatsImplPublishRateLimitedTimes :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplPublishers :: Maybe [PublisherStats] -- ^ 
  , partitionedTopicStatsImplReplication :: Maybe (Map.Map String ReplicatorStats) -- ^ 
  , partitionedTopicStatsImplStorageSize :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplSubscriptions :: Maybe (Map.Map String SubscriptionStats) -- ^ 
  , partitionedTopicStatsImplSystemTopicBytesInCounter :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplTopicCreationTimeStamp :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplTopicEpoch :: Maybe Integer -- ^ 
  , partitionedTopicStatsImplWaitingPublishers :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PartitionedTopicStatsImpl where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "partitionedTopicStatsImpl")
instance ToJSON PartitionedTopicStatsImpl where
  toJSON = genericToJSON (removeFieldLabelPrefix False "partitionedTopicStatsImpl")


-- | 
data PendingBookieOpsStats = PendingBookieOpsStats
  { pendingBookieOpsStatsCursorLedgerCloseOp :: Maybe Integer -- ^ 
  , pendingBookieOpsStatsCursorLedgerCreateOp :: Maybe Integer -- ^ 
  , pendingBookieOpsStatsCursorLedgerDeleteOp :: Maybe Integer -- ^ 
  , pendingBookieOpsStatsCursorLedgerOpenOp :: Maybe Integer -- ^ 
  , pendingBookieOpsStatsDataLedgerCloseOp :: Maybe Integer -- ^ 
  , pendingBookieOpsStatsDataLedgerCreateOp :: Maybe Integer -- ^ 
  , pendingBookieOpsStatsDataLedgerDeleteOp :: Maybe Integer -- ^ 
  , pendingBookieOpsStatsDataLedgerOpenOp :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PendingBookieOpsStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "pendingBookieOpsStats")
instance ToJSON PendingBookieOpsStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "pendingBookieOpsStats")


-- | 
data PersistencePolicies = PersistencePolicies
  { persistencePoliciesBookkeeperAckQuorum :: Maybe Int -- ^ 
  , persistencePoliciesBookkeeperEnsemble :: Maybe Int -- ^ 
  , persistencePoliciesBookkeeperWriteQuorum :: Maybe Int -- ^ 
  , persistencePoliciesManagedLedgerMaxMarkDeleteRate :: Maybe Double -- ^ 
  , persistencePoliciesManagedLedgerStorageClassName :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PersistencePolicies where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "persistencePolicies")
instance ToJSON PersistencePolicies where
  toJSON = genericToJSON (removeFieldLabelPrefix False "persistencePolicies")


-- | 
data PersistentOfflineTopicStats = PersistentOfflineTopicStats
  { persistentOfflineTopicStatsBrokerName :: Maybe Text -- ^ 
  , persistentOfflineTopicStatsCursorDetails :: Maybe (Map.Map String CursorDetails) -- ^ 
  , persistentOfflineTopicStatsDataLedgerDetails :: Maybe [LedgerDetails] -- ^ 
  , persistentOfflineTopicStatsMessageBacklog :: Maybe Integer -- ^ 
  , persistentOfflineTopicStatsStatGeneratedAt :: Maybe UTCTime -- ^ 
  , persistentOfflineTopicStatsStorageSize :: Maybe Integer -- ^ 
  , persistentOfflineTopicStatsTopicName :: Maybe Text -- ^ 
  , persistentOfflineTopicStatsTotalMessages :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PersistentOfflineTopicStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "persistentOfflineTopicStats")
instance ToJSON PersistentOfflineTopicStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "persistentOfflineTopicStats")


-- | 
data PersistentTopicInternalStats = PersistentTopicInternalStats
  { persistentTopicInternalStatsCompactedLedger :: Maybe LedgerInfo -- ^ 
  , persistentTopicInternalStatsCurrentLedgerEntries :: Maybe Integer -- ^ 
  , persistentTopicInternalStatsCurrentLedgerSize :: Maybe Integer -- ^ 
  , persistentTopicInternalStatsCursors :: Maybe (Map.Map String CursorStats) -- ^ 
  , persistentTopicInternalStatsEntriesAddedCounter :: Maybe Integer -- ^ 
  , persistentTopicInternalStatsLastConfirmedEntry :: Maybe Text -- ^ 
  , persistentTopicInternalStatsLastLedgerCreatedTimestamp :: Maybe Text -- ^ 
  , persistentTopicInternalStatsLastLedgerCreationFailureTimestamp :: Maybe Text -- ^ 
  , persistentTopicInternalStatsLedgers :: Maybe [LedgerInfo] -- ^ 
  , persistentTopicInternalStatsNumberOfEntries :: Maybe Integer -- ^ 
  , persistentTopicInternalStatsPendingAddEntriesCount :: Maybe Int -- ^ 
  , persistentTopicInternalStatsSchemaLedgers :: Maybe [LedgerInfo] -- ^ 
  , persistentTopicInternalStatsState :: Maybe Text -- ^ 
  , persistentTopicInternalStatsTotalSize :: Maybe Integer -- ^ 
  , persistentTopicInternalStatsWaitingCursorsCount :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PersistentTopicInternalStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "persistentTopicInternalStats")
instance ToJSON PersistentTopicInternalStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "persistentTopicInternalStats")


-- | 
data PersistentTopicStats = PersistentTopicStats
  { persistentTopicStatsAverageMsgSize :: Maybe Double -- ^ 
  , persistentTopicStatsBacklogQuotaLimitSize :: Maybe Integer -- ^ 
  , persistentTopicStatsBacklogQuotaLimitTime :: Maybe Integer -- ^ 
  , persistentTopicStatsBacklogSize :: Maybe Integer -- ^ 
  , persistentTopicStatsBytesInCounter :: Maybe Integer -- ^ 
  , persistentTopicStatsBytesOutCounter :: Maybe Integer -- ^ 
  , persistentTopicStatsCompaction :: Maybe CompactionStats -- ^ 
  , persistentTopicStatsDeduplicationStatus :: Maybe Text -- ^ 
  , persistentTopicStatsDelayedMessageIndexSizeInBytes :: Maybe Integer -- ^ 
  , persistentTopicStatsEarliestMsgPublishTimeInBacklogs :: Maybe Integer -- ^ 
  , persistentTopicStatsLastPublishTimeStamp :: Maybe Integer -- ^ 
  , persistentTopicStatsMsgChunkPublished :: Maybe Bool -- ^ 
  , persistentTopicStatsMsgInCounter :: Maybe Integer -- ^ 
  , persistentTopicStatsMsgOutCounter :: Maybe Integer -- ^ 
  , persistentTopicStatsMsgRateIn :: Maybe Double -- ^ 
  , persistentTopicStatsMsgRateOut :: Maybe Double -- ^ 
  , persistentTopicStatsMsgThroughputIn :: Maybe Double -- ^ 
  , persistentTopicStatsMsgThroughputOut :: Maybe Double -- ^ 
  , persistentTopicStatsNonContiguousDeletedMessagesRanges :: Maybe Int -- ^ 
  , persistentTopicStatsNonContiguousDeletedMessagesRangesSerializedSize :: Maybe Int -- ^ 
  , persistentTopicStatsOffloadedStorageSize :: Maybe Integer -- ^ 
  , persistentTopicStatsOldestBacklogMessageAgeSeconds :: Maybe Integer -- ^ 
  , persistentTopicStatsOldestBacklogMessageSubscriptionName :: Maybe Text -- ^ 
  , persistentTopicStatsOwnerBroker :: Maybe Text -- ^ 
  , persistentTopicStatsPublishers :: Maybe [PublisherStats] -- ^ 
  , persistentTopicStatsReplication :: Maybe (Map.Map String ReplicatorStats) -- ^ 
  , persistentTopicStatsStorageSize :: Maybe Integer -- ^ 
  , persistentTopicStatsSubscriptions :: Maybe (Map.Map String SubscriptionStats) -- ^ 
  , persistentTopicStatsTopicCreationTimeStamp :: Maybe Integer -- ^ 
  , persistentTopicStatsTopicEpoch :: Maybe Integer -- ^ 
  , persistentTopicStatsWaitingPublishers :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PersistentTopicStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "persistentTopicStats")
instance ToJSON PersistentTopicStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "persistentTopicStats")


-- | 
data Policies = Policies
  { policiesAllowedUnderscoreclusters :: Maybe [Text] -- ^ 
  , policiesAuthUnderscorepolicies :: Maybe AuthPolicies -- ^ 
  , policiesAutoSubscriptionCreationOverride :: Maybe AutoSubscriptionCreationOverride -- ^ 
  , policiesAutoTopicCreationOverride :: Maybe AutoTopicCreationOverride -- ^ 
  , policiesBacklogUnderscorequotaUnderscoremap :: Maybe (Map.Map String BacklogQuota) -- ^ 
  , policiesBundles :: Maybe BundlesData -- ^ 
  , policiesClusterDispatchRate :: Maybe (Map.Map String DispatchRateImpl) -- ^ 
  , policiesClusterSubscribeRate :: Maybe (Map.Map String SubscribeRate) -- ^ 
  , policiesCompactionUnderscorethreshold :: Maybe Integer -- ^ 
  , policiesDeduplicationEnabled :: Maybe Bool -- ^ 
  , policiesDeduplicationSnapshotIntervalSeconds :: Maybe Int -- ^ 
  , policiesDelayedUnderscoredeliveryUnderscorepolicies :: Maybe DelayedDeliveryPolicies -- ^ 
  , policiesDeleted :: Maybe Bool -- ^ 
  , policiesDispatcherPauseOnAckStatePersistentEnabled :: Maybe Bool -- ^ 
  , policiesEncryptionUnderscorerequired :: Maybe Bool -- ^ 
  , policiesEntryFilters :: Maybe EntryFilters -- ^ 
  , policiesInactiveUnderscoretopicUnderscorepolicies :: Maybe InactiveTopicPolicies -- ^ 
  , policiesIsUnderscoreallowUnderscoreautoUnderscoreupdateUnderscoreschema :: Maybe Bool -- ^ 
  , policiesLatencyUnderscorestatsUnderscoresampleUnderscorerate :: Maybe (Map.Map String Int) -- ^ 
  , policiesMaxUnderscoreconsumersUnderscoreperUnderscoresubscription :: Maybe Int -- ^ 
  , policiesMaxUnderscoreconsumersUnderscoreperUnderscoretopic :: Maybe Int -- ^ 
  , policiesMaxUnderscoreproducersUnderscoreperUnderscoretopic :: Maybe Int -- ^ 
  , policiesMaxUnderscoresubscriptionsUnderscoreperUnderscoretopic :: Maybe Int -- ^ 
  , policiesMaxUnderscoretopicsUnderscoreperUnderscorenamespace :: Maybe Int -- ^ 
  , policiesMaxUnderscoreunackedUnderscoremessagesUnderscoreperUnderscoreconsumer :: Maybe Int -- ^ 
  , policiesMaxUnderscoreunackedUnderscoremessagesUnderscoreperUnderscoresubscription :: Maybe Int -- ^ 
  , policiesMessageUnderscorettlUnderscoreinUnderscoreseconds :: Maybe Int -- ^ 
  , policiesMigrated :: Maybe Bool -- ^ 
  , policiesOffloadUnderscoredeletionUnderscorelagUnderscorems :: Maybe Integer -- ^ 
  , policiesOffloadUnderscorepolicies :: Maybe OffloadPolicies -- ^ 
  , policiesOffloadUnderscorethreshold :: Maybe Integer -- ^ 
  , policiesOffloadUnderscorethresholdUnderscoreinUnderscoreseconds :: Maybe Integer -- ^ 
  , policiesPersistence :: Maybe PersistencePolicies -- ^ 
  , policiesProperties :: Maybe (Map.Map String Text) -- ^ 
  , policiesPublishMaxMessageRate :: Maybe (Map.Map String PublishRate) -- ^ 
  , policiesReplicationUnderscoreclusters :: Maybe [Text] -- ^ 
  , policiesReplicatorDispatchRate :: Maybe (Map.Map String DispatchRateImpl) -- ^ 
  , policiesResourceUnderscoregroupUnderscorename :: Maybe Text -- ^ 
  , policiesRetentionUnderscorepolicies :: Maybe RetentionPolicies -- ^ 
  , policiesSchemaUnderscoreautoUnderscoreupdateUnderscorecompatibilityUnderscorestrategy :: Maybe Text -- ^ 
  , policiesSchemaUnderscorecompatibilityUnderscorestrategy :: Maybe Text -- ^ 
  , policiesSchemaUnderscorevalidationUnderscoreenforced :: Maybe Bool -- ^ 
  , policiesSubscriptionDispatchRate :: Maybe (Map.Map String DispatchRateImpl) -- ^ 
  , policiesSubscriptionUnderscoreauthUnderscoremode :: Maybe Text -- ^ 
  , policiesSubscriptionUnderscoreexpirationUnderscoretimeUnderscoreminutes :: Maybe Int -- ^ 
  , policiesSubscriptionUnderscoretypesUnderscoreenabled :: Maybe [Text] -- ^ 
  , policiesTopicDispatchRate :: Maybe (Map.Map String DispatchRateImpl) -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON Policies where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "policies")
instance ToJSON Policies where
  toJSON = genericToJSON (removeFieldLabelPrefix False "policies")


-- | 
data PoolArenaStats = PoolArenaStats
  { poolArenaStatsChunkLists :: Maybe [PoolChunkListStats] -- ^ 
  , poolArenaStatsNumActiveAllocations :: Maybe Integer -- ^ 
  , poolArenaStatsNumActiveHugeAllocations :: Maybe Integer -- ^ 
  , poolArenaStatsNumActiveNormalAllocations :: Maybe Integer -- ^ 
  , poolArenaStatsNumActiveSmallAllocations :: Maybe Integer -- ^ 
  , poolArenaStatsNumAllocations :: Maybe Integer -- ^ 
  , poolArenaStatsNumChunkLists :: Maybe Int -- ^ 
  , poolArenaStatsNumDeallocations :: Maybe Integer -- ^ 
  , poolArenaStatsNumHugeAllocations :: Maybe Integer -- ^ 
  , poolArenaStatsNumHugeDeallocations :: Maybe Integer -- ^ 
  , poolArenaStatsNumNormalAllocations :: Maybe Integer -- ^ 
  , poolArenaStatsNumNormalDeallocations :: Maybe Integer -- ^ 
  , poolArenaStatsNumSmallAllocations :: Maybe Integer -- ^ 
  , poolArenaStatsNumSmallDeallocations :: Maybe Integer -- ^ 
  , poolArenaStatsNumSmallSubpages :: Maybe Int -- ^ 
  , poolArenaStatsSmallSubpages :: Maybe [PoolSubpageStats] -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PoolArenaStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "poolArenaStats")
instance ToJSON PoolArenaStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "poolArenaStats")


-- | 
data PoolChunkListStats = PoolChunkListStats
  { poolChunkListStatsChunks :: Maybe [PoolChunkStats] -- ^ 
  , poolChunkListStatsMaxUsage :: Maybe Int -- ^ 
  , poolChunkListStatsMinUsage :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PoolChunkListStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "poolChunkListStats")
instance ToJSON PoolChunkListStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "poolChunkListStats")


-- | 
data PoolChunkStats = PoolChunkStats
  { poolChunkStatsChunkSize :: Maybe Int -- ^ 
  , poolChunkStatsFreeBytes :: Maybe Int -- ^ 
  , poolChunkStatsUsage :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PoolChunkStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "poolChunkStats")
instance ToJSON PoolChunkStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "poolChunkStats")


-- | 
data PoolSubpageStats = PoolSubpageStats
  { poolSubpageStatsElementSize :: Maybe Int -- ^ 
  , poolSubpageStatsMaxNumElements :: Maybe Int -- ^ 
  , poolSubpageStatsNumAvailable :: Maybe Int -- ^ 
  , poolSubpageStatsPageSize :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PoolSubpageStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "poolSubpageStats")
instance ToJSON PoolSubpageStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "poolSubpageStats")


-- | 
data PositionInfo = PositionInfo
  { positionInfoEntryId :: Maybe Integer -- ^ 
  , positionInfoLedgerId :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PositionInfo where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "positionInfo")
instance ToJSON PositionInfo where
  toJSON = genericToJSON (removeFieldLabelPrefix False "positionInfo")


-- | 
data PostSchemaPayload = PostSchemaPayload
  { postSchemaPayloadProperties :: Maybe (Map.Map String Text) -- ^ 
  , postSchemaPayloadSchema :: Maybe Text -- ^ 
  , postSchemaPayloadType :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PostSchemaPayload where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "postSchemaPayload")
instance ToJSON PostSchemaPayload where
  toJSON = genericToJSON (removeFieldLabelPrefix False "postSchemaPayload")


-- | 
data PostSchemaResponse = PostSchemaResponse
  { postSchemaResponseVersion :: Maybe Value -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PostSchemaResponse where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "postSchemaResponse")
instance ToJSON PostSchemaResponse where
  toJSON = genericToJSON (removeFieldLabelPrefix False "postSchemaResponse")


-- | 
data ProcessContainerFactory = ProcessContainerFactory
  { processContainerFactoryExtraFunctionDependenciesDir :: Maybe Text -- ^ 
  , processContainerFactoryJavaInstanceJarLocation :: Maybe Text -- ^ 
  , processContainerFactoryLogDirectory :: Maybe Text -- ^ 
  , processContainerFactoryPythonInstanceLocation :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON ProcessContainerFactory where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "processContainerFactory")
instance ToJSON ProcessContainerFactory where
  toJSON = genericToJSON (removeFieldLabelPrefix False "processContainerFactory")


-- | 
data PublicKey = PublicKey
  { publicKeyAlgorithm :: Maybe Text -- ^ 
  , publicKeyEncoded :: Maybe [Text] -- ^ 
  , publicKeyFormat :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PublicKey where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "publicKey")
instance ToJSON PublicKey where
  toJSON = genericToJSON (removeFieldLabelPrefix False "publicKey")


-- | 
data PublishRate = PublishRate
  { publishRatePublishThrottlingRateInByte :: Maybe Integer -- ^ 
  , publishRatePublishThrottlingRateInMsg :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PublishRate where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "publishRate")
instance ToJSON PublishRate where
  toJSON = genericToJSON (removeFieldLabelPrefix False "publishRate")


-- | 
data PublisherStats = PublisherStats
  { publisherStatsAccessMode :: Maybe Text -- ^ 
  , publisherStatsAddress :: Maybe Text -- ^ 
  , publisherStatsAverageMsgSize :: Maybe Double -- ^ 
  , publisherStatsChunkedMessageRate :: Maybe Double -- ^ 
  , publisherStatsClientVersion :: Maybe Text -- ^ 
  , publisherStatsConnectedSince :: Maybe Text -- ^ 
  , publisherStatsMetadata :: Maybe (Map.Map String Text) -- ^ 
  , publisherStatsMsgRateIn :: Maybe Double -- ^ 
  , publisherStatsMsgThroughputIn :: Maybe Double -- ^ 
  , publisherStatsProducerId :: Maybe Integer -- ^ 
  , publisherStatsProducerName :: Maybe Text -- ^ 
  , publisherStatsSupportsPartialProducer :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON PublisherStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "publisherStats")
instance ToJSON PublisherStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "publisherStats")


-- | 
data RawBookieInfo = RawBookieInfo
  { rawBookieInfoBookieId :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON RawBookieInfo where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "rawBookieInfo")
instance ToJSON RawBookieInfo where
  toJSON = genericToJSON (removeFieldLabelPrefix False "rawBookieInfo")


-- | 
data ReplicatorStats = ReplicatorStats
  { replicatorStatsBytesInCount :: Maybe Integer -- ^ 
  , replicatorStatsBytesOutCount :: Maybe Integer -- ^ 
  , replicatorStatsConnected :: Maybe Bool -- ^ 
  , replicatorStatsInboundConnectedSince :: Maybe Text -- ^ 
  , replicatorStatsInboundConnection :: Maybe Text -- ^ 
  , replicatorStatsMsgExpiredCount :: Maybe Integer -- ^ 
  , replicatorStatsMsgInCount :: Maybe Integer -- ^ 
  , replicatorStatsMsgOutCount :: Maybe Integer -- ^ 
  , replicatorStatsMsgRateExpired :: Maybe Double -- ^ 
  , replicatorStatsMsgRateIn :: Maybe Double -- ^ 
  , replicatorStatsMsgRateOut :: Maybe Double -- ^ 
  , replicatorStatsMsgThroughputIn :: Maybe Double -- ^ 
  , replicatorStatsMsgThroughputOut :: Maybe Double -- ^ 
  , replicatorStatsOutboundConnectedSince :: Maybe Text -- ^ 
  , replicatorStatsOutboundConnection :: Maybe Text -- ^ 
  , replicatorStatsReplicationBacklog :: Maybe Integer -- ^ 
  , replicatorStatsReplicationDelayInSeconds :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON ReplicatorStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "replicatorStats")
instance ToJSON ReplicatorStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "replicatorStats")


-- | 
data ResetCursorData = ResetCursorData
  { resetCursorDataBatchIndex :: Maybe Int -- ^ 
  , resetCursorDataEntryId :: Maybe Integer -- ^ 
  , resetCursorDataExcluded :: Maybe Bool -- ^ 
  , resetCursorDataLedgerId :: Maybe Integer -- ^ 
  , resetCursorDataPartitionIndex :: Maybe Int -- ^ 
  , resetCursorDataProperties :: Maybe (Map.Map String Text) -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON ResetCursorData where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "resetCursorData")
instance ToJSON ResetCursorData where
  toJSON = genericToJSON (removeFieldLabelPrefix False "resetCursorData")


-- | 
data ResourceDescription = ResourceDescription
  { resourceDescriptionResourceUsage :: Maybe (Map.Map String ResourceUsage) -- ^ 
  , resourceDescriptionUsagePct :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON ResourceDescription where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "resourceDescription")
instance ToJSON ResourceDescription where
  toJSON = genericToJSON (removeFieldLabelPrefix False "resourceDescription")


-- | 
data ResourceGroup = ResourceGroup
  { resourceGroupDispatchRateInBytes :: Maybe Integer -- ^ 
  , resourceGroupDispatchRateInMsgs :: Maybe Int -- ^ 
  , resourceGroupPublishRateInBytes :: Maybe Integer -- ^ 
  , resourceGroupPublishRateInMsgs :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON ResourceGroup where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "resourceGroup")
instance ToJSON ResourceGroup where
  toJSON = genericToJSON (removeFieldLabelPrefix False "resourceGroup")


-- | 
data ResourceQuota = ResourceQuota
  { resourceQuotaBandwidthIn :: Maybe Double -- ^ 
  , resourceQuotaBandwidthOut :: Maybe Double -- ^ 
  , resourceQuotaDynamic :: Maybe Bool -- ^ 
  , resourceQuotaMemory :: Maybe Double -- ^ 
  , resourceQuotaMsgRateIn :: Maybe Double -- ^ 
  , resourceQuotaMsgRateOut :: Maybe Double -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON ResourceQuota where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "resourceQuota")
instance ToJSON ResourceQuota where
  toJSON = genericToJSON (removeFieldLabelPrefix False "resourceQuota")


-- | 
data ResourceUnit = ResourceUnit
  { resourceUnitAvailableResource :: Maybe ResourceDescription -- ^ 
  , resourceUnitResourceId :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON ResourceUnit where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "resourceUnit")
instance ToJSON ResourceUnit where
  toJSON = genericToJSON (removeFieldLabelPrefix False "resourceUnit")


-- | 
data ResourceUsage = ResourceUsage
  { resourceUsageLimit :: Maybe Double -- ^ 
  , resourceUsageUsage :: Maybe Double -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON ResourceUsage where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "resourceUsage")
instance ToJSON ResourceUsage where
  toJSON = genericToJSON (removeFieldLabelPrefix False "resourceUsage")


-- | 
data Resources = Resources
  { resourcesCpu :: Maybe Double -- ^ 
  , resourcesDisk :: Maybe Integer -- ^ 
  , resourcesRam :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON Resources where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "resources")
instance ToJSON Resources where
  toJSON = genericToJSON (removeFieldLabelPrefix False "resources")


-- | 
data RetentionPolicies = RetentionPolicies
  { retentionPoliciesRetentionSizeInMB :: Maybe Integer -- ^ 
  , retentionPoliciesRetentionTimeInMinutes :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON RetentionPolicies where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "retentionPolicies")
instance ToJSON RetentionPolicies where
  toJSON = genericToJSON (removeFieldLabelPrefix False "retentionPolicies")


-- | 
data Sinks = Sinks
  { sinksListOfConnectors :: Maybe [ConnectorDefinition] -- ^ 
  , sinksSinkList :: Maybe [ConnectorDefinition] -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON Sinks where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "sinks")
instance ToJSON Sinks where
  toJSON = genericToJSON (removeFieldLabelPrefix False "sinks")


-- | 
data SinksWorkerService = SinksWorkerService
  { sinksWorkerServiceListOfConnectors :: Maybe [ConnectorDefinition] -- ^ 
  , sinksWorkerServiceSinkList :: Maybe [ConnectorDefinition] -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON SinksWorkerService where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "sinksWorkerService")
instance ToJSON SinksWorkerService where
  toJSON = genericToJSON (removeFieldLabelPrefix False "sinksWorkerService")


-- | 
data Sources = Sources
  { sourcesListOfConnectors :: Maybe [ConnectorDefinition] -- ^ 
  , sourcesSourceList :: Maybe [ConnectorDefinition] -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON Sources where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "sources")
instance ToJSON Sources where
  toJSON = genericToJSON (removeFieldLabelPrefix False "sources")


-- | 
data SourcesWorkerService = SourcesWorkerService
  { sourcesWorkerServiceListOfConnectors :: Maybe [ConnectorDefinition] -- ^ 
  , sourcesWorkerServiceSourceList :: Maybe [ConnectorDefinition] -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON SourcesWorkerService where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "sourcesWorkerService")
instance ToJSON SourcesWorkerService where
  toJSON = genericToJSON (removeFieldLabelPrefix False "sourcesWorkerService")


-- | 
data SubscribeRate = SubscribeRate
  { subscribeRateRatePeriodInSecond :: Maybe Int -- ^ 
  , subscribeRateSubscribeThrottlingRatePerConsumer :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON SubscribeRate where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "subscribeRate")
instance ToJSON SubscribeRate where
  toJSON = genericToJSON (removeFieldLabelPrefix False "subscribeRate")


-- | 
data SubscriptionStats = SubscriptionStats
  { subscriptionStatsActiveConsumerName :: Maybe Text -- ^ 
  , subscriptionStatsAllowOutOfOrderDelivery :: Maybe Bool -- ^ 
  , subscriptionStatsBacklogSize :: Maybe Integer -- ^ 
  , subscriptionStatsBlockedSubscriptionOnUnackedMsgs :: Maybe Bool -- ^ 
  , subscriptionStatsBytesOutCounter :: Maybe Integer -- ^ 
  , subscriptionStatsChunkedMessageRate :: Maybe Double -- ^ 
  , subscriptionStatsConsumers :: Maybe [ConsumerStats] -- ^ 
  , subscriptionStatsConsumersAfterMarkDeletePosition :: Maybe (Map.Map String Text) -- ^ 
  , subscriptionStatsDelayedMessageIndexSizeInBytes :: Maybe Integer -- ^ 
  , subscriptionStatsDispatchThrottledBytesEventsByBrokerLimit :: Maybe Integer -- ^ 
  , subscriptionStatsDispatchThrottledBytesEventsBySubscriptionLimit :: Maybe Integer -- ^ 
  , subscriptionStatsDispatchThrottledBytesEventsByTopicLimit :: Maybe Integer -- ^ 
  , subscriptionStatsDispatchThrottledMsgEventsByBrokerLimit :: Maybe Integer -- ^ 
  , subscriptionStatsDispatchThrottledMsgEventsBySubscriptionLimit :: Maybe Integer -- ^ 
  , subscriptionStatsDispatchThrottledMsgEventsByTopicLimit :: Maybe Integer -- ^ 
  , subscriptionStatsDrainingHashesClearedTotal :: Maybe Integer -- ^ 
  , subscriptionStatsDrainingHashesCount :: Maybe Int -- ^ 
  , subscriptionStatsDrainingHashesUnackedMessages :: Maybe Int -- ^ 
  , subscriptionStatsDurable :: Maybe Bool -- ^ 
  , subscriptionStatsEarliestMsgPublishTimeInBacklog :: Maybe Integer -- ^ 
  , subscriptionStatsFilterAcceptedMsgCount :: Maybe Integer -- ^ 
  , subscriptionStatsFilterProcessedMsgCount :: Maybe Integer -- ^ 
  , subscriptionStatsFilterRejectedMsgCount :: Maybe Integer -- ^ 
  , subscriptionStatsFilterRescheduledMsgCount :: Maybe Integer -- ^ 
  , subscriptionStatsKeySharedMode :: Maybe Text -- ^ 
  , subscriptionStatsLastAckedTimestamp :: Maybe Integer -- ^ 
  , subscriptionStatsLastConsumedFlowTimestamp :: Maybe Integer -- ^ 
  , subscriptionStatsLastConsumedTimestamp :: Maybe Integer -- ^ 
  , subscriptionStatsLastExpireTimestamp :: Maybe Integer -- ^ 
  , subscriptionStatsLastMarkDeleteAdvancedTimestamp :: Maybe Integer -- ^ 
  , subscriptionStatsMessageAckRate :: Maybe Double -- ^ 
  , subscriptionStatsMsgBacklog :: Maybe Integer -- ^ 
  , subscriptionStatsMsgBacklogNoDelayed :: Maybe Integer -- ^ 
  , subscriptionStatsMsgDelayed :: Maybe Integer -- ^ 
  , subscriptionStatsMsgInReplay :: Maybe Integer -- ^ 
  , subscriptionStatsMsgOutCounter :: Maybe Integer -- ^ 
  , subscriptionStatsMsgRateExpired :: Maybe Double -- ^ 
  , subscriptionStatsMsgRateOut :: Maybe Double -- ^ 
  , subscriptionStatsMsgRateRedeliver :: Maybe Double -- ^ 
  , subscriptionStatsMsgThroughputOut :: Maybe Double -- ^ 
  , subscriptionStatsNonContiguousDeletedMessagesRanges :: Maybe Int -- ^ 
  , subscriptionStatsNonContiguousDeletedMessagesRangesSerializedSize :: Maybe Int -- ^ 
  , subscriptionStatsReplicated :: Maybe Bool -- ^ 
  , subscriptionStatsSubscriptionProperties :: Maybe (Map.Map String Text) -- ^ 
  , subscriptionStatsTotalMsgExpired :: Maybe Integer -- ^ 
  , subscriptionStatsType :: Maybe Text -- ^ 
  , subscriptionStatsUnackedMessages :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON SubscriptionStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "subscriptionStats")
instance ToJSON SubscriptionStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "subscriptionStats")


-- | 
data SystemResourceUsage = SystemResourceUsage
  { systemResourceUsageBandwidthIn :: Maybe ResourceUsage -- ^ 
  , systemResourceUsageBandwidthOut :: Maybe ResourceUsage -- ^ 
  , systemResourceUsageCpu :: Maybe ResourceUsage -- ^ 
  , systemResourceUsageDirectMemory :: Maybe ResourceUsage -- ^ 
  , systemResourceUsageMemory :: Maybe ResourceUsage -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON SystemResourceUsage where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "systemResourceUsage")
instance ToJSON SystemResourceUsage where
  toJSON = genericToJSON (removeFieldLabelPrefix False "systemResourceUsage")


-- | Information of adminRoles and allowedClusters for tenant
data TenantInfo = TenantInfo
  { tenantInfoAdminRoles :: Maybe [Text] -- ^ Comma separated list of auth principal allowed to administrate the tenant.
  , tenantInfoAllowedClusters :: Maybe [Text] -- ^ Comma separated allowed clusters.
  } deriving (Show, Eq, Generic)

instance FromJSON TenantInfo where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "tenantInfo")
instance ToJSON TenantInfo where
  toJSON = genericToJSON (removeFieldLabelPrefix False "tenantInfo")


-- | 
data ThreadContainerFactory = ThreadContainerFactory
  { threadContainerFactoryPulsarClientMemoryLimit :: Maybe MemoryLimit -- ^ 
  , threadContainerFactoryThreadGroupName :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON ThreadContainerFactory where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "threadContainerFactory")
instance ToJSON ThreadContainerFactory where
  toJSON = genericToJSON (removeFieldLabelPrefix False "threadContainerFactory")


-- | 
data TopicHashPositions = TopicHashPositions
  { topicHashPositionsBundle :: Maybe Text -- ^ 
  , topicHashPositionsNamespace :: Maybe Text -- ^ 
  , topicHashPositionsTopicHashPositions :: Maybe (Map.Map String Integer) -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON TopicHashPositions where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "topicHashPositions")
instance ToJSON TopicHashPositions where
  toJSON = genericToJSON (removeFieldLabelPrefix False "topicHashPositions")


-- | 
data TopicStats = TopicStats
  { topicStatsAverageMsgSize :: Maybe Double -- ^ 
  , topicStatsBacklogQuotaLimitSize :: Maybe Integer -- ^ 
  , topicStatsBacklogQuotaLimitTime :: Maybe Integer -- ^ 
  , topicStatsBacklogSize :: Maybe Integer -- ^ 
  , topicStatsBytesInCounter :: Maybe Integer -- ^ 
  , topicStatsBytesOutCounter :: Maybe Integer -- ^ 
  , topicStatsCompaction :: Maybe CompactionStats -- ^ 
  , topicStatsDeduplicationStatus :: Maybe Text -- ^ 
  , topicStatsDelayedMessageIndexSizeInBytes :: Maybe Integer -- ^ 
  , topicStatsEarliestMsgPublishTimeInBacklogs :: Maybe Integer -- ^ 
  , topicStatsLastPublishTimeStamp :: Maybe Integer -- ^ 
  , topicStatsMsgChunkPublished :: Maybe Bool -- ^ 
  , topicStatsMsgInCounter :: Maybe Integer -- ^ 
  , topicStatsMsgOutCounter :: Maybe Integer -- ^ 
  , topicStatsMsgRateIn :: Maybe Double -- ^ 
  , topicStatsMsgRateOut :: Maybe Double -- ^ 
  , topicStatsMsgThroughputIn :: Maybe Double -- ^ 
  , topicStatsMsgThroughputOut :: Maybe Double -- ^ 
  , topicStatsNonContiguousDeletedMessagesRanges :: Maybe Int -- ^ 
  , topicStatsNonContiguousDeletedMessagesRangesSerializedSize :: Maybe Int -- ^ 
  , topicStatsOffloadedStorageSize :: Maybe Integer -- ^ 
  , topicStatsOldestBacklogMessageAgeSeconds :: Maybe Integer -- ^ 
  , topicStatsOldestBacklogMessageSubscriptionName :: Maybe Text -- ^ 
  , topicStatsOwnerBroker :: Maybe Text -- ^ 
  , topicStatsPublishers :: Maybe [PublisherStats] -- ^ 
  , topicStatsReplication :: Maybe (Map.Map String ReplicatorStats) -- ^ 
  , topicStatsStorageSize :: Maybe Integer -- ^ 
  , topicStatsSubscriptions :: Maybe (Map.Map String SubscriptionStats) -- ^ 
  , topicStatsTopicCreationTimeStamp :: Maybe Integer -- ^ 
  , topicStatsTopicEpoch :: Maybe Integer -- ^ 
  , topicStatsWaitingPublishers :: Maybe Int -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON TopicStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "topicStats")
instance ToJSON TopicStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "topicStats")


-- | 
data WorkerConfig = WorkerConfig
  { workerConfigAdditionalEnabledConnectorUrlPatterns :: Maybe [Text] -- ^ 
  , workerConfigAdditionalEnabledFunctionsUrlPatterns :: Maybe [Text] -- ^ 
  , workerConfigAdditionalJavaRuntimeArguments :: Maybe [Text] -- ^ 
  , workerConfigAssignmentWriteMaxRetries :: Maybe Int -- ^ 
  , workerConfigAuthenticateMetricsEndpoint :: Maybe Bool -- ^ 
  , workerConfigAuthenticationEnabled :: Maybe Bool -- ^ 
  , workerConfigAuthenticationProviders :: Maybe [Text] -- ^ 
  , workerConfigAuthorizationEnabled :: Maybe Bool -- ^ 
  , workerConfigAuthorizationProvider :: Maybe Text -- ^ 
  , workerConfigBookkeeperClientAuthenticationParameters :: Maybe Text -- ^ 
  , workerConfigBookkeeperClientAuthenticationParametersName :: Maybe Text -- ^ 
  , workerConfigBookkeeperClientAuthenticationPlugin :: Maybe Text -- ^ 
  , workerConfigBrokerClientAuthenticationEnabled :: Maybe Bool -- ^ 
  , workerConfigBrokerClientAuthenticationParameters :: Maybe Text -- ^ 
  , workerConfigBrokerClientAuthenticationPlugin :: Maybe Text -- ^ 
  , workerConfigBrokerClientTrustCertsFilePath :: Maybe Text -- ^ 
  , workerConfigClientAuthenticationParameters :: Maybe Text -- ^ 
  , workerConfigClientAuthenticationPlugin :: Maybe Text -- ^ 
  , workerConfigClusterCoordinationTopic :: Maybe Text -- ^ 
  , workerConfigClusterCoordinationTopicName :: Maybe Text -- ^ 
  , workerConfigConfigurationMetadataStoreUrl :: Maybe Text -- ^ 
  , workerConfigConfigurationStoreServers :: Maybe Text -- ^ 
  , workerConfigConnectorsDirectory :: Maybe Text -- ^ 
  , workerConfigDownloadDirectory :: Maybe Text -- ^ 
  , workerConfigEnableClassloadingOfBuiltinFiles :: Maybe Bool -- ^ 
  , workerConfigEnableClassloadingOfExternalFiles :: Maybe Bool -- ^ 
  , workerConfigEnableReferencingConnectorDirectoryFiles :: Maybe Bool -- ^ 
  , workerConfigEnableReferencingFunctionsDirectoryFiles :: Maybe Bool -- ^ 
  , workerConfigExposeAdminClientEnabled :: Maybe Bool -- ^ 
  , workerConfigFailureCheckFreqMs :: Maybe Integer -- ^ 
  , workerConfigForwardSourceMessageProperty :: Maybe Bool -- ^ 
  , workerConfigFunctionAssignmentTopic :: Maybe Text -- ^ 
  , workerConfigFunctionAssignmentTopicName :: Maybe Text -- ^ 
  , workerConfigFunctionAuthProviderClassName :: Maybe Text -- ^ 
  , workerConfigFunctionInstanceMaxResources :: Maybe Resources -- ^ 
  , workerConfigFunctionInstanceMinResources :: Maybe Resources -- ^ 
  , workerConfigFunctionInstanceResourceChangeInLockStep :: Maybe Bool -- ^ 
  , workerConfigFunctionInstanceResourceGranularities :: Maybe Resources -- ^ 
  , workerConfigFunctionMetadataTopic :: Maybe Text -- ^ 
  , workerConfigFunctionMetadataTopicName :: Maybe Text -- ^ 
  , workerConfigFunctionRuntimeFactoryClassName :: Maybe Text -- ^ 
  , workerConfigFunctionRuntimeFactoryConfigs :: Maybe (Map.Map String Value) -- ^ 
  , workerConfigFunctionWebServiceUrl :: Maybe Text -- ^ 
  , workerConfigFunctionsDirectory :: Maybe Text -- ^ 
  , workerConfigFunctionsWorkerEnablePackageManagement :: Maybe Bool -- ^ 
  , workerConfigFunctionsWorkerServiceCustomConfigs :: Maybe (Map.Map String Value) -- ^ 
  , workerConfigFunctionsWorkerServiceNarPackage :: Maybe Text -- ^ 
  , workerConfigHttpRequestsLimitEnabled :: Maybe Bool -- ^ 
  , workerConfigHttpRequestsMaxPerSecond :: Maybe Double -- ^ 
  , workerConfigHttpServerAcceptQueueSize :: Maybe Int -- ^ 
  , workerConfigHttpServerThreadPoolQueueSize :: Maybe Int -- ^ 
  , workerConfigIgnoreUnknownConfigFields :: Maybe Bool -- ^ 
  , workerConfigIncludeStandardPrometheusMetrics :: Maybe Bool -- ^ 
  , workerConfigInitialBrokerReconnectMaxRetries :: Maybe Int -- ^ 
  , workerConfigInitializedDlogMetadata :: Maybe Bool -- ^ 
  , workerConfigInstanceLivenessCheckFreqMs :: Maybe Integer -- ^ 
  , workerConfigJvmGCMetricsLoggerClassName :: Maybe Text -- ^ 
  , workerConfigKinitCommand :: Maybe Text -- ^ 
  , workerConfigKubernetesContainerFactory :: Maybe KubernetesContainerFactory -- ^ 
  , workerConfigMaxConcurrentHttpRequests :: Maybe Int -- ^ 
  , workerConfigMaxHttpServerConnections :: Maybe Int -- ^ 
  , workerConfigMaxPendingAsyncRequests :: Maybe Int -- ^ 
  , workerConfigMetadataStoreAllowReadOnlyOperations :: Maybe Bool -- ^ 
  , workerConfigMetadataStoreCacheExpirySeconds :: Maybe Int -- ^ 
  , workerConfigMetadataStoreOperationTimeoutSeconds :: Maybe Int -- ^ 
  , workerConfigMetadataStoreSessionTimeoutMillis :: Maybe Integer -- ^ 
  , workerConfigNarExtractionDirectory :: Maybe Text -- ^ 
  , workerConfigNumFunctionPackageReplicas :: Maybe Int -- ^ 
  , workerConfigNumHttpServerThreads :: Maybe Int -- ^ 
  , workerConfigProcessContainerFactory :: Maybe ProcessContainerFactory -- ^ 
  , workerConfigProperties :: Maybe (Map.Map String Text) -- ^ 
  , workerConfigProxyRoles :: Maybe [Text] -- ^ 
  , workerConfigPulsarFunctionsCluster :: Maybe Text -- ^ 
  , workerConfigPulsarFunctionsNamespace :: Maybe Text -- ^ 
  , workerConfigPulsarServiceUrl :: Maybe Text -- ^ 
  , workerConfigPulsarWebServiceUrl :: Maybe Text -- ^ 
  , workerConfigRebalanceCheckFreqSec :: Maybe Integer -- ^ 
  , workerConfigRescheduleTimeoutMs :: Maybe Integer -- ^ 
  , workerConfigRuntimeCustomizerClassName :: Maybe Text -- ^ 
  , workerConfigRuntimeCustomizerConfig :: Maybe (Map.Map String Value) -- ^ 
  , workerConfigSaslJaasClientAllowedIds :: Maybe Text -- ^ 
  , workerConfigSaslJaasServerRoleTokenSignerSecretPath :: Maybe Text -- ^ 
  , workerConfigSaslJaasServerSectionName :: Maybe Text -- ^ 
  , workerConfigSchedulerClassName :: Maybe Text -- ^ 
  , workerConfigSecretsProviderConfiguratorClassName :: Maybe Text -- ^ 
  , workerConfigSecretsProviderConfiguratorConfig :: Maybe (Map.Map String Text) -- ^ 
  , workerConfigStateStorageProviderImplementation :: Maybe Text -- ^ 
  , workerConfigStateStorageServiceUrl :: Maybe Text -- ^ 
  , workerConfigSuperUserRoles :: Maybe [Text] -- ^ 
  , workerConfigThreadContainerFactory :: Maybe ThreadContainerFactory -- ^ 
  , workerConfigTlsAllowInsecureConnection :: Maybe Bool -- ^ 
  , workerConfigTlsCertRefreshCheckDurationSec :: Maybe Integer -- ^ 
  , workerConfigTlsCertificateFilePath :: Maybe Text -- ^ 
  , workerConfigTlsEnableHostnameVerification :: Maybe Bool -- ^ 
  , workerConfigTlsEnabled :: Maybe Bool -- ^ 
  , workerConfigTlsEnabledWithKeyStore :: Maybe Bool -- ^ 
  , workerConfigTlsKeyFilePath :: Maybe Text -- ^ 
  , workerConfigTlsKeyStore :: Maybe Text -- ^ 
  , workerConfigTlsKeyStorePassword :: Maybe Text -- ^ 
  , workerConfigTlsKeyStoreType :: Maybe Text -- ^ 
  , workerConfigTlsProvider :: Maybe Text -- ^ 
  , workerConfigTlsRequireTrustedClientCertOnConnect :: Maybe Bool -- ^ 
  , workerConfigTlsTrustCertsFilePath :: Maybe Text -- ^ 
  , workerConfigTlsTrustChainBytes :: Maybe [Text] -- ^ 
  , workerConfigTlsTrustStore :: Maybe Text -- ^ 
  , workerConfigTlsTrustStorePassword :: Maybe Text -- ^ 
  , workerConfigTlsTrustStoreType :: Maybe Text -- ^ 
  , workerConfigTopicCompactionFrequencySec :: Maybe Integer -- ^ 
  , workerConfigUploadBuiltinSinksSources :: Maybe Bool -- ^ 
  , workerConfigUseCompactedMetadataTopic :: Maybe Bool -- ^ 
  , workerConfigUseTls :: Maybe Bool -- ^ 
  , workerConfigValidateConnectorConfig :: Maybe Bool -- ^ 
  , workerConfigWebServiceHaProxyProtocolEnabled :: Maybe Bool -- ^ 
  , workerConfigWebServiceLogDetailedAddresses :: Maybe Bool -- ^ 
  , workerConfigWebServiceTlsCiphers :: Maybe [Text] -- ^ 
  , workerConfigWebServiceTlsProtocols :: Maybe [Text] -- ^ 
  , workerConfigWebServiceTrustXForwardedFor :: Maybe Bool -- ^ 
  , workerConfigWorkerHostname :: Maybe Text -- ^ 
  , workerConfigWorkerId :: Maybe Text -- ^ 
  , workerConfigWorkerListProbeIntervalSec :: Maybe Int -- ^ 
  , workerConfigWorkerPort :: Maybe Int -- ^ 
  , workerConfigWorkerPortTls :: Maybe Int -- ^ 
  , workerConfigWorkerWebAddress :: Maybe Text -- ^ 
  , workerConfigWorkerWebAddressTls :: Maybe Text -- ^ 
  , workerConfigZooKeeperAllowReadOnlyOperations :: Maybe Bool -- ^ 
  , workerConfigZooKeeperCacheExpirySeconds :: Maybe Int -- ^ 
  , workerConfigZooKeeperOperationTimeoutSeconds :: Maybe Int -- ^ 
  , workerConfigZooKeeperSessionTimeoutMillis :: Maybe Integer -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON WorkerConfig where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "workerConfig")
instance ToJSON WorkerConfig where
  toJSON = genericToJSON (removeFieldLabelPrefix False "workerConfig")


-- | 
data WorkerFunctionInstanceStats = WorkerFunctionInstanceStats
  { workerFunctionInstanceStatsMetrics :: Maybe FunctionInstanceStatsData -- ^ 
  , workerFunctionInstanceStatsName :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON WorkerFunctionInstanceStats where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "workerFunctionInstanceStats")
instance ToJSON WorkerFunctionInstanceStats where
  toJSON = genericToJSON (removeFieldLabelPrefix False "workerFunctionInstanceStats")


-- | 
data WorkerInfo = WorkerInfo
  { workerInfoPort :: Maybe Int -- ^ 
  , workerInfoWorkerHostname :: Maybe Text -- ^ 
  , workerInfoWorkerId :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON WorkerInfo where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "workerInfo")
instance ToJSON WorkerInfo where
  toJSON = genericToJSON (removeFieldLabelPrefix False "workerInfo")


-- | 
data WorkerService = WorkerService
  { workerServiceFunctions :: Maybe FunctionsWorkerService -- ^ 
  , workerServiceFunctionsV2 :: Maybe FunctionsV2WorkerService -- ^ 
  , workerServiceInitialized :: Maybe Bool -- ^ 
  , workerServiceSinks :: Maybe SinksWorkerService -- ^ 
  , workerServiceSources :: Maybe SourcesWorkerService -- ^ 
  , workerServiceWorkerConfig :: Maybe WorkerConfig -- ^ 
  , workerServiceWorkers :: Maybe Value -- ^ 
  } deriving (Show, Eq, Generic)

instance FromJSON WorkerService where
  parseJSON = genericParseJSON (removeFieldLabelPrefix True "workerService")
instance ToJSON WorkerService where
  toJSON = genericToJSON (removeFieldLabelPrefix False "workerService")


uncapitalize :: String -> String
uncapitalize (first:rest) = Char.toLower first : rest
uncapitalize [] = []

-- | Remove a field label prefix during JSON parsing.
--   Also perform any replacements for special characters.
--   The @forParsing@ parameter is to distinguish between the cases in which we're using this
--   to power a @FromJSON@ or a @ToJSON@ instance. In the first case we're parsing, and we want
--   to replace special characters with their quoted equivalents (because we cannot have special
--   chars in identifier names), while we want to do viceversa when sending data instead.
removeFieldLabelPrefix :: Bool -> String -> Options
removeFieldLabelPrefix forParsing prefix =
  defaultOptions
    { omitNothingFields  = True
    , fieldLabelModifier = uncapitalize . fromMaybe (error ("did not find prefix " ++ prefix)) . stripPrefix prefix . replaceSpecialChars
    }
  where
    replaceSpecialChars field = foldl (&) field (map mkCharReplacement specialChars)
    specialChars =
      [ ("@", "'At")
      , ("\\", "'Back_Slash")
      , ("<=", "'Less_Than_Or_Equal_To")
      , ("\"", "'Double_Quote")
      , ("[", "'Left_Square_Bracket")
      , ("]", "'Right_Square_Bracket")
      , ("^", "'Caret")
      , ("_", "'Underscore")
      , ("`", "'Backtick")
      , ("!", "'Exclamation")
      , ("#", "'Hash")
      , ("$", "'Dollar")
      , ("%", "'Percent")
      , ("&", "'Ampersand")
      , ("'", "'Quote")
      , ("(", "'Left_Parenthesis")
      , (")", "'Right_Parenthesis")
      , ("*", "'Star")
      , ("+", "'Plus")
      , (",", "'Comma")
      , ("-", "'Dash")
      , (".", "'Period")
      , ("/", "'Slash")
      , (":", "'Colon")
      , ("{", "'Left_Curly_Bracket")
      , ("|", "'Pipe")
      , ("<", "'LessThan")
      , ("!=", "'Not_Equal")
      , ("=", "'Equal")
      , ("}", "'Right_Curly_Bracket")
      , (">", "'GreaterThan")
      , ("~", "'Tilde")
      , ("?", "'Question_Mark")
      , (">=", "'Greater_Than_Or_Equal_To")
      , ("~=", "'Tilde_Equal")
      ]
    mkCharReplacement (replaceStr, searchStr) = T.unpack . replacer (T.pack searchStr) (T.pack replaceStr) . T.pack
    replacer =
      if forParsing
        then flip T.replace
        else T.replace
